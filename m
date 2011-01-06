From: daeinki <inki.dae@samsung.com>
Date: Thu, 06 Jan 2011 12:57:06 +0000
Subject: Memory sharing issue by application on V4L2 based device driver with
Message-Id: <4D25BC22.6080803@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org


Hello, all.

I'd like to discuss memory sharing issue by application on v4l2 based
device driver with system mmu and get some advices about that.

Now I am working on Samsung SoC C210 platform and this platform has some
multimedia devices with system mmu such as fimc, and mfc also we have
implemented device drivers for them. those drivers are based on V4L2
framework with videobuf2. for system mmu of each device, we used
VCM(Virtual Contiguous Memory) framework.

Simply, VCM framework provides  physical memory, device virtual memory
allocation and memory mapping between them. when device driver is
initialized or operated by user application, each driver allocates
physical memory and device virtual memory and then mapping using VCM
interface.

refer to below link for more detail.
http://www.spinics.net/lists/linux-media/msg26548.html

Physical memory access process is as the following.
            DVA                          PA
device --------------> system mmu ------------------> physical memory

DVA : device virtual address.
PA : physical address.

like this, device virtual address should be set to buffer(source or
destination) register of multimedia device.

the problem is that application want to share own memory with any device
driver to avoid memory copy. in other words, user-allocated memory could
be source or destination memory of multimedia device driver.


let's see the diagram below.

                user application

                      |
                      |
                      |
                      |
                      |  1. UVA(allocated by malloc)
                      |
                      |
                    =A1=AC|/                   2. UVA(in page unit)

        -----> multimedia device driver -------------------> videobuf2
        |
        |        |     ^                                         |
        |        |     |                                         |
        |        |     -------------------------------------------
        |        |                    3. PA(in page unit)
        |        |
        |        | 4. PA(in page unit)
6. DVA  |        |
        |        |
        |        |
        |      =A1=AC|/
        |
        |       Virtual Contiguous Memory ---------
        |                                         |
        |           |     ^                       |
        |           |     |                       | 5. map PA to DVA
        |           |     |                       |
        |           |     |                       |
        -------------     -------------------------

PA : physical address.
UVA : user virtual address.
DVA : device virtual address.

1. user application allocates user space memory through malloc function
and sending it to multimedia device driver based on v4l2 framework
through userptr feature.

2, 3. multimedia device driver gets translated physical address from
videobuf2 framework in page unit.

4, 5. multimedia device driver gets allocated device virtual address and
mapping it to physical address and then mapping them through VCM interface.

6. multimedia device driver sets device virtual address from VCM to
buffer register.

the diagram above is fully theoretical so I wonder that this way is
reasonable and has some problems also what should be considered.

thank you for your interesting.
