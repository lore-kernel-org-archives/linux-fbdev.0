From: Otto Solares <solca@guug.org>
Subject: Re: framebuffer ioctl
Date: Tue, 7 Sep 2004 12:09:05 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040907180905.GA809@guug.org>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be> <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net> <20040906184306.GA29544@guug.org> <9e47339104090612086149bfd7@mail.gmail.com> <20040906192400.GB29544@guug.org> <9e47339104090612334b3623ee@mail.gmail.com> <413DD83D.7B9F5D92@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4kP0-0003io-D2
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 11:09:10 -0700
Received: from guug.org ([168.234.203.30])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4kOy-0007qu-Sz
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 11:09:10 -0700
Received: from solca by guug.org with local (Exim 3.36 #1 (Debian))
	id 1C4kOv-0000EI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Sep 2004 12:09:05 -0600
Content-Disposition: inline
In-Reply-To: <413DD83D.7B9F5D92@orpatec.ch>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

On Tue, Sep 07, 2004 at 05:48:13PM +0200, Otto Wyss wrote:
> Jon Smirl wrote:
> > 
> > > > Teach him about mesa-solo and he won't want to extend fbdev.
> > >
> I coudln't find much useful information about mesa-solo, is it the same
> as miniglx? Is there any link?

In reality is not hard to program for mesa-solo, just the init code
is the trickiest part as you must initialize the fbdev and *magically*
find a working video mode (which is always hard regardless you are
using mesa-solo).  Anything else is pure OpenGL.  If you need the init
code I have a working one but I don't use miniglx but driUtil routines.

> > > -otto
> Hi Otto, is that me or is that you ;-)

Probably you but sounds like me :)

-otto


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
