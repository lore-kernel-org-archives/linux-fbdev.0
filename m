From: Ritesh Prajapati <ritesh.prajapati@slscorp.com>
Date: Thu, 18 Dec 2014 07:17:18 +0000
Subject: Need Help to create frame buffer driver under Linux System
Message-Id: <54927CAE.7060604@slscorp.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi,

     I have one FPGA board which has DDR3 memory, HDMI Video Interface
as well as PCIe Interface. So, I want to use that board as graphics card
in my Linux System.

     That FPGA board is connected via PCIe Interface in my system. I
have created one sample PCI Driver to enable pci device and get some
properties like BAR information for DDR3 memory.

      I have also created frame buffer driver using virtual frame buffer
driver reference and mapped video memory with DDR3 memory which are
connected on FPGA board.

     Can anyone helped me about how to manage multiple frame buffer in
DDR3 memory from frame buffer driver? Also please provide some more
information about how to create full functional frame buffer driver in
Linux.

     Please let me know if need more information.

-- 
Regards,
Ritesh Prajapati,
System Level Solutions (India) Pvt.Ltd.




