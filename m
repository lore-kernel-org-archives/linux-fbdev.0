From: Randy Dunlap <rdunlap@xenotime.net>
Date: Tue, 13 Mar 2012 20:30:27 +0000
Subject: [PATCH] x86: export 'pcibios_enabled'
Message-Id: <4F5FAE63.3090908@xenotime.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120313204114.e160849af7dbe5a4b4e5c0ad@canb.auug.org.au>
In-Reply-To: <20120313204114.e160849af7dbe5a4b4e5c0ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Michal Januszewski <spock@gentoo.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>

From: Randy Dunlap <rdunlap@xenotime.net>

Export 'pcibios_enabled' so that when uvesafb is built as a
loadable module (on X86_32), the build will succeed.

ERROR: "pcibios_enabled" [drivers/video/uvesafb.ko] undefined!

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Cc:	Michal Januszewski <spock@gentoo.org>
Cc:	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc:	linux-fbdev@vger.kernel.org
Cc:	x86@kernel.org
---
Applies to mainline; found in linux-next.

 arch/x86/pci/pcbios.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20120313.orig/arch/x86/pci/pcbios.c
+++ linux-next-20120313/arch/x86/pci/pcbios.c
@@ -27,6 +27,7 @@
 #define PCIBIOS_HW_TYPE2_SPEC		0x20
 
 int pcibios_enabled;
+EXPORT_SYMBOL(pcibios_enabled);
 
 /* According to the BIOS specification at:
  * http://members.datafast.net.au/dft0802/specs/bios21.pdf, we could
