From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] drivers/video/geode/video_gx.c: make struct gx_pll_table_48MHz static
Date: Fri, 10 Feb 2006 01:43:55 +0100
Message-ID: <20060210004355.GJ3524@stusta.de>
References: <20060207220627.345107c3.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750900AbWBJAn5@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060207220627.345107c3.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, David Vrabel <dvrabel@arcom.com>
Cc: linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net

On Tue, Feb 07, 2006 at 10:06:27PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc1-mm5:
>...
> +fbdev-framebuffer-driver-for-geode-gx.patch
>...
>  fbdev updates/drivers/fixes
>...


There is no good reason for struct gx_pll_table_48MHz being global.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc2-mm1-full/drivers/video/geode/video_gx.c.old	2006-02-10 00:55:07.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/drivers/video/geode/video_gx.c	2006-02-10 00:56:13.000000000 +0100
@@ -34,7 +34,7 @@
 #define PREMULT2 ((u32)MSR_GLCP_SYS_RSTPLL_DOTPREMULT2)
 #define PREDIV2  ((u32)MSR_GLCP_SYS_RSTPLL_DOTPOSTDIV3)
 
-struct gx_pll_entry gx_pll_table_48MHz[] = {
+static struct gx_pll_entry gx_pll_table_48MHz[] = {
 	{ 40123, POSTDIV3,	    0x00000BF2 },	/*  24.9230 */
 	{ 39721, 0,		    0x00000037 },	/*  25.1750 */
 	{ 35308, POSTDIV3|PREMULT2, 0x00000B1A },	/*  28.3220 */
