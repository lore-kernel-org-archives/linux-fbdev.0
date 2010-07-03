From: InKi Dae <inki.dae@samsung.com>
Subject: [PATCH v1 0/2] ARM: S5PV210: Add MIPI-DSI support.
Date: Sat, 03 Jul 2010 17:33:31 +0900
Message-ID: <4C2EF5DB.7070102@samsung.com>
References: <4C29AF72.6090200@samsung.com> <4C2DA7BE.6070701@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <4C2DA7BE.6070701@samsung.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, Ben Dooks <ben-linux@fluff.org>, kmpark@infradead.org

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
