resource "google_compute_network" "network" {
  name                      = var.name
  auto_create_subnetworks   = false
  project                   = var.project_id
}

resource "google_compute_subnetwork" "subnet" {
  name                      = var.subnetwork
  ip_cidr_range             = var.nodes_network
  region                    = var.region
  network                   = google_compute_network.network.self_link
  project                   = var.project_id
}

resource "google_compute_router" "router" {
  name                      = format("%s-router",var.name)
  project                   = var.project_id
  region                    = google_compute_subnetwork.subnet.region
  network                   = google_compute_network.network.self_link
}

resource "google_compute_address" "address" {
  name                      = format("%s-nat-external-address",var.name)
  region                    = var.region
  project                   = var.project_id
}

resource "google_compute_router_nat" "advanced-nat" {
  name                               = format("%s-nat-1",var.name)
  router                             = google_compute_router.router.name
  region                             = var.region
  project                            = var.project_id
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.address.self_link]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                             = google_compute_subnetwork.subnet.self_link
    source_ip_ranges_to_nat          = ["ALL_IP_RANGES"]
  }
}



