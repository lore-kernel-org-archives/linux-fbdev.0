From: Andrew Morton <akpm@osdl.org>
Subject: Re: Radeon framebuffer weirdness in -mm2
Date: Thu, 20 Jan 2005 16:01:23 -0800
Message-ID: <20050120160123.14f13ca6.akpm@osdl.org>
References: <20050120232122.GF3867@waste.org>
	<20050120153921.11d7c4fa.akpm@osdl.org>
	<20050120234844.GF12076@waste.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrmAO-0007kN-CS
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 15:56:44 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CrmAN-0006Qs-QF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 15:56:44 -0800
In-Reply-To: <20050120234844.GF12076@waste.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, ajoshi@shell.unixbox.com, linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org

Matt Mackall <mpm@selenic.com> wrote:
>
> > Which radeon driver? CONFIG_FB_RADEON_OLD or CONFIG_FB_RADEON?
> 
> FB_RADEON.

Ah, OK.  Likely culprits are

radeonfb-massive-update-of-pm-code.patch
radeonfb-build-fix.patch



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
