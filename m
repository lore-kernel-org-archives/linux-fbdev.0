From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: framebuffer with nvidia 7600GS
	shows	corrupt screen
Date: Sat, 26 May 2007 07:17:18 +0800
Message-ID: <1180135038.4627.22.camel@daplas>
References: <20070523181826.GA4331@amd64.of.nowhere>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hrj2C-0003dF-Je for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 May 2007 16:17:24 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hrj2C-0007jF-7M
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 May 2007 16:17:24 -0700
Received: by py-out-1112.google.com with SMTP id u77so1580075pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 25 May 2007 16:17:23 -0700 (PDT)
In-Reply-To: <20070523181826.GA4331@amd64.of.nowhere>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jurriaan <thunder7@xs4all.nl>

On Wed, 2007-05-23 at 20:18 +0200, jurriaan wrote:
> I've swapped my nvidia 6600 for a 7600GS, because it has dual-link DVI
> output. That broke my framebuffer!

I haven't sync'ed nvidiafb with xorg's nv driver, so your chipset is not
properly supported yet. I'll send you a patch when it's ready.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
