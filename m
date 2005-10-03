From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: VESA, EDID & flat panels
Date: Tue, 04 Oct 2005 08:53:33 +1000
Message-ID: <1128380013.8267.125.camel@gaston>
Reply-To: Discuss issues related to the xorg tree <xorg@lists.freedesktop.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <xorg-bounces@lists.freedesktop.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: Discuss issues related to the xorg tree <xorg@lists.freedesktop.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi !

Somebody around here has access to the VESA specs ? I'm trying to figure
out if the EDID block, at least on recent flat panels, tells us wether
the panel digital input is 6:6:6 or 8:8:8 ... If it's 6:6:6, we should
enable dithering in drivers like radeon and "nv", while if 8:8:8, we
should not. If not enabling it on a 6 bits panel, we end up with crappy
looking gradients, if enabling it on a 8 bits panel, we basically end up
sending a 6 bits signal to a 8 bits panel, thus reducing the quality.

Ben.
