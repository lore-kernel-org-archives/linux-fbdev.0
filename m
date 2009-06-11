From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: PATCH - Add accelerated bitblt functions to
	s1d13xxxfb
Date: Thu, 11 Jun 2009 23:07:16 +0200
Message-ID: <20090611230716.7965e16b.kristoffer.ericson@gmail.com>
References: <20090606141037.7debdb08.kristoffer.ericson@gmail.com>
	<20090609175807.65db0ebb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Thu__11_Jun_2009_23_07_16_+0200_8jhZcx6eKRpoZK0K"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1MErTk-0000Nv-7O
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Jun 2009 21:06:32 +0000
Received: from mail-bw0-f222.google.com ([209.85.218.222])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MErTj-0006sj-7B for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Jun 2009 21:06:32 +0000
Received: by bwz22 with SMTP id 22so1789152bwz.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 11 Jun 2009 14:06:29 -0700 (PDT)
In-Reply-To: <20090609175807.65db0ebb.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--Multipart=_Thu__11_Jun_2009_23_07_16_+0200_8jhZcx6eKRpoZK0K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2009 17:58:07 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sat, 6 Jun 2009 14:10:37 +0200
> Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> 
> > This patch adds accelerated bitblt functions to s1d13xxx based 
> > video chipsets, more specificly functions copyarea and fillrect. 
> > It has only been tested and activated for 13506 chipsets
> > but is expected to work for the majority of s1d13xxx based chips.
> > This patch also cleans up the driver with respect of whitespaces
> > and other formatting issues. We update the current status
> > comments.
> > 
> 
> Was I sent half a patch?
> 
Sorry for late reply!

I must have missed appending the changes in s1d13xxx.h. Do you want a resend of the complete
patch or just whats missing? Here are the missing lines:

diff --git a/include/video/s1d13xxxfb.h b/include/video/s1d13xxxfb.h
index c3b2a2a..f0736cf 100644
--- a/include/video/s1d13xxxfb.h
+++ b/include/video/s1d13xxxfb.h
@@ -136,6 +136,15 @@
 #define S1DREG_DELAYOFF			0xFFFE
 #define S1DREG_DELAYON			0xFFFF
 
+#define BBLT_FIFO_EMPTY			0x00
+#define BBLT_FIFO_NOT_EMPTY		0x40
+#define BBLT_FIFO_NOT_FULL		0x30
+#define BBLT_FIFO_HALF_FULL		0x20
+#define BBLT_FIFO_FULL			0x10
+
+#define BBLT_SOLID_FILL			0x0c
+
+
 /* Note: all above defines should go in separate header files
    when implementing other S1D13xxx chip support. */
 


> 
> drivers/video/s1d13xxxfb.c: In function 'bltbit_fifo_status':
> drivers/video/s1d13xxxfb.c:470: error: 'BBLT_FIFO_EMPTY' undeclared (first use in this function)
> drivers/video/s1d13xxxfb.c:470: error: (Each undeclared identifier is reported only once
> drivers/video/s1d13xxxfb.c:470: error: for each function it appears in.)
> drivers/video/s1d13xxxfb.c:474: error: 'BBLT_FIFO_FULL' undeclared (first use in this function)
> drivers/video/s1d13xxxfb.c:478: error: 'BBLT_FIFO_NOT_FULL' undeclared (first use in this function)
> drivers/video/s1d13xxxfb.c: In function 's1d13xxxfb_bitblt_solidfill':
> drivers/video/s1d13xxxfb.c:640: error: 'BBLT_SOLID_FILL' undeclared (first use in this function)


-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Multipart=_Thu__11_Jun_2009_23_07_16_+0200_8jhZcx6eKRpoZK0K
Content-Type: application/octet-stream;
 name="s1d13xxxfb.h.patch"
Content-Disposition: attachment;
 filename="s1d13xxxfb.h.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvdmlkZW8vczFkMTN4eHhmYi5oIGIvaW5jbHVkZS92aWRlby9z
MWQxM3h4eGZiLmgKaW5kZXggYzNiMmEyYS4uZjA3MzZjZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS92
aWRlby9zMWQxM3h4eGZiLmgKKysrIGIvaW5jbHVkZS92aWRlby9zMWQxM3h4eGZiLmgKQEAgLTEz
Niw2ICsxMzYsMTUgQEAKICNkZWZpbmUgUzFEUkVHX0RFTEFZT0ZGCQkJMHhGRkZFCiAjZGVmaW5l
IFMxRFJFR19ERUxBWU9OCQkJMHhGRkZGCiAKKyNkZWZpbmUgQkJMVF9GSUZPX0VNUFRZCQkJMHgw
MAorI2RlZmluZSBCQkxUX0ZJRk9fTk9UX0VNUFRZCQkweDQwCisjZGVmaW5lIEJCTFRfRklGT19O
T1RfRlVMTAkJMHgzMAorI2RlZmluZSBCQkxUX0ZJRk9fSEFMRl9GVUxMCQkweDIwCisjZGVmaW5l
IEJCTFRfRklGT19GVUxMCQkJMHgxMAorCisjZGVmaW5lIEJCTFRfU09MSURfRklMTAkJCTB4MGMK
KworCiAvKiBOb3RlOiBhbGwgYWJvdmUgZGVmaW5lcyBzaG91bGQgZ28gaW4gc2VwYXJhdGUgaGVh
ZGVyIGZpbGVzCiAgICB3aGVuIGltcGxlbWVudGluZyBvdGhlciBTMUQxM3h4eCBjaGlwIHN1cHBv
cnQuICovCiAK

--Multipart=_Thu__11_Jun_2009_23_07_16_+0200_8jhZcx6eKRpoZK0K
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--Multipart=_Thu__11_Jun_2009_23_07_16_+0200_8jhZcx6eKRpoZK0K
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--Multipart=_Thu__11_Jun_2009_23_07_16_+0200_8jhZcx6eKRpoZK0K--
