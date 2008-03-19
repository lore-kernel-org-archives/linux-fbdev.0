From: York Sun <yorksun@freescale.com>
Subject: v2 patch for Freescale DIU driver
Date: Wed, 19 Mar 2008 13:50:25 -0500
Message-ID: <12059526271941-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net


This is the version 2 patch for Freescale DIU driver. Thanks for all the feedback.

The first patch is the driver. The second patch adds platform support for MPC8610HPCD board.
To compile, enable the "Freescale MPC8610/MPC5121 DIU framebuffer support" in the menuconfig.
