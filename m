From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Mesa3d-dev] RE: [Dri-devel] Memory management of AGP and VRAM
Date: Mon, 10 May 2004 08:59:07 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1084175946.24578.12.camel@localhost.localdomain>
References: <20040509164514.17651.qmail@web14922.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040509164514.17651.qmail@web14922.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Ian Romanick <idr@us.ibm.com>, Egbert Eich <eich@pdx.freedesktop.org>, DRI Devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sul, 2004-05-09 at 17:45, Jon Smirl wrote:
> Also, these is no rule saying a device driver can't have several tables of _init
> register values that can be used to set the mode on a primary monitor at boot. I
> would just like to see all of the code that does DDC decoding and modeline
> computations moved to user space.

But there should also be no rule that says it cannot be in kernel space.
Lets take the Voodoo2 again, the mode computation is *tiny*.
Or many embedded devices where the modes are very simple to set up.

The API at user space for the driver modules has to leave the question
of *who* does what private to the driver.



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
