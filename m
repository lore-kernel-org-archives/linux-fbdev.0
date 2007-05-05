From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] Xilinx framebuffer device driver -
	4th version
Date: Sat, 05 May 2007 18:44:29 +0800
Message-ID: <1178361869.4706.0.camel@daplas>
References: <463B504C.5050500@ru.mvista.com> <1178309961.4729.7.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkHkm-0005bQ-HN for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 03:44:41 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkHkl-0005RI-W1
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 03:44:40 -0700
Received: by py-out-1112.google.com with SMTP id p76so862175pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 03:44:39 -0700 (PDT)
In-Reply-To: <1178309961.4729.7.camel@daplas>
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
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linuxppc-embedded@ozlabs.org

On Sat, 2007-05-05 at 04:19 +0800, Antonino A. Daplas wrote:
> On Fri, 2007-05-04 at 19:25 +0400, Andrei Konovalov wrote:
> > Add support for the video controller IP block included into Xilinx ML300
> > and ML403 reference designs.
> > 
> 
> My tree does not have arch/ppc/syslib/virtex_devices.h. Either I wait
> for that to be merged to the -mm or mainline tree, or you can submit
> this driver yourself with the platform-specific changes. Either way:

Okay, the platform-specific parts are in 2.6.21-mm1 already. I'll push
this patch upstairs.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
