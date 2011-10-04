From: nello martuscielli <ppc.addon@gmail.com>
Subject: ping: [PATCH] GXT4000P and GXT6500P support
Date: Tue, 4 Oct 2011 13:56:57 +0200
Message-ID: <CABMX=Wxbm+v0ntPT2Br6D_xSpe7XhASEoxzq99ExoYUZ4eDj5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: linuxppc-dev@lists.ozlabs.org, linux-fbdev-devel@lists.sourceforge.net
Cc: Nico Macrionitisl <acrux@cruxppc.org>

ping for: http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/072678.html

This patch adds support for GXT4000P and GXT6500P cards found on some
IBM pSeries machines.
GXT4000P/6000P and GXT4500P/6500P  couples are  identical from
software's point of view and are based on the same  Raster Engine
(RC1000), except for a different reference clock for the PLL.
GXT6x00P models are equipped with an additional Geometry Engine
(GT1000) but this driver doesn't use it.


I see that even after 2 years, this patch still hasn't been added to
the official Linux kernel.
You will appreciate how little code this took to save everybody with a
GXT6500P card some trouble.

cheers,
Nello
--
CRUX PPC user on IBM POWER4+
