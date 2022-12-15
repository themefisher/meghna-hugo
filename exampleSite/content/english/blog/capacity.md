---
title: Wi-Fi Capacity Design
date: 2022-12-15T09:51:12.000+00:00
image_webp: "/images/blog/wifi-capacity-design.webp"
image: "/images/blog/wifi-capacity-design.png"
author: wifi-ninja
description: 'wi-fi, design, capacity, best practice '

---
Adopting the right approach to Wi-Fi is critical to increase reliance on Wi-Fi networks as a mission-critical resource. Supporting the growing quantity of wireless devices and delivering high performance that meets or exceeds user expectations is key to a successful WLAN.

    <a href="http://google.com/" target="_blank">Hello, world!</a>
    <https://google.com>

Historically, many Wi-Fi networks have been designed to provide basic coverage throughout a desired service area. While a “coverage-oriented” design can meet basic Wi-Fi network access needs, supporting only a few users and light workload, a different approach is required to support a growing Wi-Fi client population. Modern Wi-Fi networks should be designed to accommodate the current and anticipated capacity and performance levels within the organization rather than focusing on providing basic coverage.

Significant capability differences exist between Wi-Fi networks designed for coverage versus those designed for capacity. The nuances between these two different approaches are often not well understood by organizational decision-makers. The use of wireless signal bars as a representation of network viability and a satisfactory user experience has proven to be a poor indicator of network success.

Many critical performance indicators cannot be conveyed through a simple signal quality indicator. For example, common mobile devices such as smartphones and tablets are designed with significantly tighter product and feature constraints to meet price and battery life demands. These mobile devices often do not support the same advanced signal processing techniques found in infrastructure APs. Although an access point may transmit at sufficient signal strength to indicate a high-quality connection on the mobile device (for example, 5-bars of signal), the mobile device may not able to reciprocate in the reverse direction. This is referred to as the “Unbalanced Power Effect” and can have a profoundly negative effect on overall performance experienced by the mobile device. In high-density environments, uplink client performance is of significant importance, as 50-100 simultaneous transmitters may exist on a single channel. Ensuring successful bi-directional communication is necessary to achieve high performance and meet capacity requirements.

A coverage-oriented design often does not factor in other critical variables required to meet performance and capacity needs, such as the following:

• Minimizing co-channel interference

• Providing sufficient spectral capacity (for example, by using colocated radios on different channels)

• Client band steering to optimize use of available spectral capacity

• Client load balancing between access points based on available airtime and load

• Meeting application bandwidth and latency requirements

• Having an end-to-end quality-of-service design

Attempting to augment a coverage-oriented Wi-Fi network to increase capacity and support dense user populations is an appealing approach for organizations looking to minimize workload and expense. However, such an approach should be met with caution, as existing constraints of the coverage-oriented network implementation can limit proper high-capacity Wi-Fi network design and ultimately fail to meet performance needs adequately. Existing constraints might include AP placement, antenna coverage patterns, and legacy equipment (802.11a/b/g) that does not align with a capacity oriented design where a greater quantity of high performance APs (802.11n) are placed closer together to support the capacity demands, and antenna coverage patterns are carefully designed to minimize co-channel interference (CCI). Many organizations are quickly realizing that existing WLAN deployments, which were designed for basic coverage requirements in common areas, are not adequate to meet these growing demands, and that simply adding more access points is ineffective without proper network planning and RF design.

A better approach is to design a high-capacity WLAN with sufficient focus on network planning and design, and to ensure the network equipment that is purchased and deployed is capable of delivering both high performance and intelligent features to optimize the use of limited spectrum. Only through proper requirements gathering, network design, configuration, and continual optimization can you deploy a Wi-Fi network that meets the demands of a dense user population.

Through the process of requirements gathering, you can identify network design objectives, allowing the Wi-Fi network to align with business objectives and to meet desired performance levels. Proper planning requires a thorough understanding of the client devices that will be supported and their capabilities, client density in each coverage area, and applications that rely on the WLAN and their associated throughput requirements.

Network design involves the synthesis of identified requirements into a network architecture that meets established capacity and performance requirements. This is accomplished by understanding and adopting design principles for a high-capacity Wi-Fi network rather than a coverage-oriented network, determining access point and radio capacity necessary to support the identified client and application requirements, and determining appropriate access point equipment, accessories and placement for optimal coverage based on facility characteristics. The process of conducting site surveys is critical to achieving a successful high-density network design.

The process of requirements gathering and network design might need to be performed for individual coverage areas if peak client density and capacity requirements are significantly different in those areas.

Network configuration translates the design requirements into a working WLAN deployment tailored for high-density environments. You can only accomplish this using advanced feature sets found in enterprise-grade Wi-Fi equipment. Therefore, an intelligent Wi-Fi infrastructure is required to accommodate client devices that are designed for home use within a complex multi-AP enterprise deployment. Enterprise-grade equipment includes high-quality hardware components that enhance network performance with consumer-oriented client devices and advanced features that optimize the use of an inherently unbounded and shared medium.

Finally, network monitoring and optimization allows you to fine-tune the deployment based on observed network performance after deployment. The network management system provides statistics collection and reporting on key metrics relevant to successful operation of the wireless network, allowing you to identify and correct unforeseen design or performance flaws.