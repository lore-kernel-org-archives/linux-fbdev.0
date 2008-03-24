From: Frans Pop <elendil@planet.nl>
Subject: Re: vga16fb: blank screen with Intel
	GM965/GL960 on HP 2510p notebook
Date: Mon, 24 Mar 2008 13:51:30 +0100
Message-ID: <200803241351.30975.elendil@planet.nl>
References: <20080321163944.GA22068@deprecation.cyrius.com>
	<200803230226.38587.elendil@planet.nl>
	<Pine.LNX.4.64.0803231005101.25605@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jdm9d-0002GD-Pc for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Mar 2008 05:51:57 -0700
Received: from cpsmtpo-eml01.kpnxchange.com ([213.75.38.150])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jdm9Z-00009F-QD
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Mar 2008 05:51:56 -0700
In-Reply-To: <Pine.LNX.4.64.0803231005101.25605@anakin>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Martin Michlmayr <tbm@cyrius.com>, Keith Packard <keith.packard@intel.com>

On Sunday 23 March 2008, Geert Uytterhoeven wrote:
> If /sys/class/graphics/fbcon exists but lsmod doesn't show fbcon?

Thanks. The first is exactly what I needed.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
