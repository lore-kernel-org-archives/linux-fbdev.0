From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: PATCH - New S1D1... Epson frambuffer maintainer
Date: Wed, 8 Oct 2008 13:08:06 +0200
Message-ID: <20081008130806.958423b3.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__8_Oct_2008_13_08_06_+0200_r2eVRFw8uQuKY6ke"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755347AbYJHLIv@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, varenet@parisc-linux.org

This is a multi-part message in MIME format.

--Multipart=_Wed__8_Oct_2008_13_08_06_+0200_r2eVRFw8uQuKY6ke
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I'm stepping up as maintainer for the Epson S1D13XXXFB driver
since I have 2 platforms currently using it.

Signed-off-by: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
Acked-by: Thibaut Var_ne <varenet@parisc-linux.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 8dae455..aed3ee5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1610,6 +1610,11 @@ P:	Christopher Hoover
 M:	ch@murgatroid.com, ch@hpl.hp.com
 S:	Maintained
 
+EPSON S1D13XXX FRAMEBUFFER DRIVER
+P:	Kristoffer Ericson
+M:	kristoffer.ericson@gmail.com
+S:	Maintained
+
 ETHEREXPRESS-16 NETWORK DRIVER
 P:	Philip Blundell
 M:	philb@gnu.org


-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Multipart=_Wed__8_Oct_2008_13_08_06_+0200_r2eVRFw8uQuKY6ke
Content-Type: application/octet-stream;
 name="epson-add-maintainer.patch"
Content-Disposition: attachment;
 filename="epson-add-maintainer.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKaW5kZXggOGRhZTQ1NS4uYWVk
M2VlNSAxMDA2NDQKLS0tIGEvTUFJTlRBSU5FUlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTE2MTAs
NiArMTYxMCwxMSBAQCBQOglDaHJpc3RvcGhlciBIb292ZXIKIE06CWNoQG11cmdhdHJvaWQuY29t
LCBjaEBocGwuaHAuY29tCiBTOglNYWludGFpbmVkCiAKK0VQU09OIFMxRDEzWFhYIEZSQU1FQlVG
RkVSIERSSVZFUgorUDoJS3Jpc3RvZmZlciBFcmljc29uCitNOglrcmlzdG9mZmVyLmVyaWNzb25A
Z21haWwuY29tCitTOglNYWludGFpbmVkCisKIEVUSEVSRVhQUkVTUy0xNiBORVRXT1JLIERSSVZF
UgogUDoJUGhpbGlwIEJsdW5kZWxsCiBNOglwaGlsYkBnbnUub3JnCg==

--Multipart=_Wed__8_Oct_2008_13_08_06_+0200_r2eVRFw8uQuKY6ke--
