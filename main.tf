data "vsphere_datacenter" "dc" {
  name = "DatacenterVDI"
}

data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "VDI CLUSTER"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "kuber-master" {
  name             = "kuber-master"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 4096

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    size             = 40
    thin_provisioned = false
  }
}

resource "vsphere_virtual_machine" "kuber-worker1" {
  name             = "kuber-worker1"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 4096

  network_interface {
    network_id = data.vsphere_network.network.id
  }
  
  disk {
    label            = "disk0"
    size             = 40
    thin_provisioned = false
  }
}


resource "vsphere_virtual_machine" "kuber-worker2" {
  name             = "kuber-worker2"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 4096

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    size             = 40
    thin_provisioned = false
  }
  disk {
    label            = "disk1"
    size             = 10
    thin_provisioned = false
    unit_number      = 1
  }
  disk {
    label            = "disk2"
    size             = 5
    thin_provisioned = false
    unit_number      = 2
  }

}
