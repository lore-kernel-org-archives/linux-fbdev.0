From: James Simmons <jsimmons@infradead.org>
Date: Tue, 06 Jul 2010 15:26:26 +0000
Subject: fw: [PATCH v1 0/2] ARM: S5PV210: Add MIPI-DSI support.
Message-Id: <alpine.LFD.2.00.1007061612280.3285@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hello all,

This patch is for MIPI-DSI controller based on S5PV210 (or S5PC110).

this version corrects some problems Ben pointed out.

v1 patch includes below contents.
- set callbacks to MIPI Client driver at mipi_ddi_platform_data declaration.
- use MIPI regulator names set at s5p_platform_dsim declaration to get regulators for them.
- use a table to get freq_band value.
- code clean and fix minor bugs.

LCD Panel can use following interfaces,
- RGB or CPU Interface.
- RGB or CPU Interface based on MIPI-DSI.

in case of cell phone device, small size lcd panel(less then 480x800) was ok only rgb or cpu interface not using mipi controller.
but big size panel(bigger then 480x800) needs MIPI-DSI Interface or other hardwares like LVDS to transfer image data to lcd panel fine.

I tested this patch on cpu interface based on MIPI-DSI and also considered RGB interface.

This patch set consists of the following patches,

[PATCH v1 1/2] S5PV210: FB: Add MIPI-DSI and CPU Interface features.
[PATCH v1 2/2] S5PV210: Add MIPI-DSI Driver.

Best regards,
InKi Dae




    [ Part 3: "Included Message" ]

From: linux-fbdev-devel-request@lists.sourceforge.net
Subject: confirm a131e69dac1c92ff53f639daca88d07fe442c6a9

If you reply to this message, keeping the Subject: header intact,
Mailman will discard the held message.  Do this if the message is
spam.  If you reply to this message and include an Approved: header
with the list password in it, the message will be approved for posting
to the list.  The Approved: header can also appear in the first line
of the body of the reply.
