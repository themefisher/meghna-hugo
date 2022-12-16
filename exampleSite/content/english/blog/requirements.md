---
title: Requirements Gathering - Wireless Infrastructure
date: 2022-12-13T12:51:12+00:00
author: wifi-ninja
image_webp: "/images/blog/requirements-gathering-wireless-infrastructure.webp"
image: "/images/blog/requirements-gathering-wireless-infrastructure.png"
description: wifi, design, requirements gathering, best practice

---
The process of requirements gathering should be the first step in designing and implementing a high-density WLAN. Through the process of requirements gathering, you can identify network design characteristics, allowing the Wi-Fi network to align with business objectives and meet desired performance levels.

Through this process, identify the following variables:

* **Wireless infrastructure capabilities** 
* **Client device types, quantities, and capabilities** 
* **Applications and throughput requirements**
[{{< newtabref  href="https://google.com" title="<TITLE FOR LINK>" >}}](google.com "test")

Once you have gathered a list of these requirements and reviewed them, you can forecast the required AP capacity for use during network planning and design. You can find a requirements gathering worksheet in the appendix to aid in this process.

### Wireless Infrastructure

The wireless network infrastructure deployed must be capable of high performance and must provide intelligent features that optimize the use of spectral capacity across a network of coordinated access points.

Many organizations are ill-equipped to evaluate these intelligent features and coordination capabilities across a sufficiently large environment and rely on isolated performance tests on a single access point in a lab environment. 

However, this does not accurately reflect the complex interactions required among access points in the presence of a dense user population. Instead, identify capabilities critical to the success of a high-density WLAN and test such capabilities prior to purchase, requesting aid from the manufacturer or their representative as appropriate.

Critical capabilities of a WLAN infrastructure that supports a high-density client population include:

**High Availability -** You can provide high availability for your WLAN by doing the following

Eliminate single points of failure with Cooperative Control architecture that works without WLAN controllers (physical or virtual).

Reduce dependence on central services to maintain WLAN availability at remote sites with integrated captive web portal, RADIUS server, LDAP directory integration, and credential caching.

Add features that enhance survivability and availability, such as dynamic radio management that detects and avoids interference and adjusts transmit power to prevent coverage holes, dual Ethernet ports on access points for redundant switch uplinks and policy-based traffic forwarding, path monitoring with failover/fail-back functionality, dynamic mesh failover with best-path forwarding capabilities.

**Hardware Enhancements** – Use high-grade, discreet components designed to compensate for low-power mobile devices that have only modest-quality transceivers. Hardware enhancements such as low-noise amplifiers, high-power amplifiers, dual-band sector array antennas, high-power/high-sensitivity radios will reduce error rates and allow continued use of higher data rates, which improves performance and increases network capacity.

**Optimized Spectral Use** – Effectively use the unlicensed spectral capacity through the following techniques:

Support all available frequency bands (ISM and UNII-1, 2, 2e, 3). 

Provide granular control of channel widths (20, 40, 80, and 160 MHz). 

Perform accurate dynamic radio management coordinated across an entire group of APs to ensure optimal channel and power selection that minimizes interference and maximizes performance. 

Implement band steering to direct clients between 2.4 GHz and 5 GHz frequency bands. Band steering is capable of directing clients in either direction between radios, as well as optimizing the client load between radios based on available capacity.

**Load Balancing** – Distribute client connections between access points based on airtime utilization to ensure proper segmentation of client traffic to maximize performance for all clients.

**Fast Secure Roaming** – The Wi-Fi Alliance® Voice-Enterprise certification allows APs to suggest to client devices when and where they should roam and provides a standardized sub-50ms roaming procedure between APs. This is particularly useful when balancing client loads across a group of APs due to heavy application use on specific APs. Other fast roaming techniques such as PMK caching and Opportunistic Key Caching (OKC) can also provide improved performance when both APs and clients support it.

**Performance Optimization** – Optimize network performance through data rate customization and granular Quality of Service (QoS) controls for converged devices. Modern Wi-Fi networks must be application-aware to identify and prioritize real-time, latency-sensitive traffic from a mixed client population and accommodate smart devices that use multiple applications with varying traffic handling requirements on a single SSID. Avoid inflexible QoS controls that tie a single traffic priority to all clients and applications on an SSID.

**Mixed Client Coexistence** – Provide optimal performance for legacy and modern Wi-Fi client devices on the same network through Dynamic Airtime Scheduling or “airtime fairness”. This ensures that legacy clients do not monopolize airtime or significantly degrade network performance of modern high-speed clients. This feature also prevents “airtime hogging” by clients operating with poor radio link quality (at lower data rates, weak SNR, sticky clients operating at a distance from the AP, or clients that are penetrating an RF obstacle).

**SLA Monitoring and Remediation** – Establish minimum performance targets with client service level assurance (SLA) and provide automatic remediation through the band steering, load balancing, and airtime boost features. Airtime boost dynamically allocates more airtime to a specific client to help it meet its SLA.

**Rate-Limiting** – Establish a maximum throughput limit to ensure greedy clients (for example, those using BitTorrent) do not starve other clients of available bandwidth via per-user or per-group rate limiting. Ratelimiting functionality is important to prevent mobile devices from consuming excessive network bandwidth for cloud storage and collaboration services.

**Enhanced Visibility** – Provide intuitive network and client health monitoring for network administrators and help desk personnel using SLA compliance metrics, client health scoring, and integrated spectrum analysis. Proper visibility allows you to perform continual network assessment and optimization as the environment changes, which is critical in high-density environments.