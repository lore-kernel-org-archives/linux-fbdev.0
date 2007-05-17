From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 01/10] fbdev: Clean up of sparc FB
	options
Date: Thu, 17 May 2007 08:10:34 +0800
Message-ID: <1179360635.28568.0.camel@daplas>
References: <1179357305.4743.20.camel@daplas>
	<20070516.161717.115911096.davem@davemloft.net>
	<1179360118.4743.32.camel@daplas>
	<20070516.170550.85686786.davem@davemloft.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoTZt-00045n-06 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 17:10:45 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HoTZs-0005BW-L5
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 17:10:44 -0700
Received: by py-out-1112.google.com with SMTP id a29so681706pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 May 2007 17:10:44 -0700 (PDT)
In-Reply-To: <20070516.170550.85686786.davem@davemloft.net>
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
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, 2007-05-16 at 17:05 -0700, David Miller wrote:
> From: "Antonino A. Daplas" <adaplas@gmail.com>
> Date: Thu, 17 May 2007 08:01:58 +0800
> 
> > The question is, will this work for sparc?
> 
> It can't be just by type, we need to be able to able to select
> individual instances of the same kind of device.  I can't tell if
> you're saying your scheme handles this or not :-)))
> 
> I can have two ffb cards in my machine and I can tell fbcon precisely
> which of those ffb instances is the primary one.  That's what I'd need
> to work.

As long as each instance is defined by distinct struct fb_info's, it
should work.

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
