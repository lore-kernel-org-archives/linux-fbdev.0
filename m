From: Ondrej Zary <linux@rainbow-software.org>
Date: Tue, 01 Mar 2011 19:17:59 +0000
Subject: [PATCH 0/5] s3fb: various changes
Message-Id: <201103012018.01607.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

This patch set adds new hardware support, fixes some display problems and also
improves performance of s3fb driver.

Everything was tested on various Trio32, Trio64V+, Trio64V2/DX, Virge, 
Virge/DX, Trio3D and Trio3D/2X cards.

It assumes that David Miller's "Make SVGA oriented FBs work on multi-domain 
PCI" patch set is applied.

Signed-off-by: David S. Miller <davem@davemloft.net>

-- 
Ondrej Zary
