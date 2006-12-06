From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: Display class
Date: Wed, 6 Dec 2006 12:28:30 -0800
Message-ID: <20061206122830.1c5fda5b.randy.dunlap@oracle.com>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
	<653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
	<Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
	<Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
	<20061205171401.fd11160d.randy.dunlap@oracle.com>
	<Pine.LNX.4.64.0612061443180.28745@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <kernel-discuss-bounces-CN5wO63fgwogsBAKwltoeQ@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0612061443180.28745-nGpKsS7K33UUkNsaar8edxWb9i9o6OzJ@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://handhelds.org/mailman/listinfo/kernel-discuss>,
	<mailto:kernel-discuss-request-CN5wO63fgwogsBAKwltoeQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://www.handhelds.org/hypermail/kernel-discuss/current>
List-Post: <mailto:kernel-discuss-CN5wO63fgwogsBAKwltoeQ@public.gmane.org>
List-Help: <mailto:kernel-discuss-request-CN5wO63fgwogsBAKwltoeQ@public.gmane.org?subject=help>
List-Subscribe: <https://handhelds.org/mailman/listinfo/kernel-discuss>,
	<mailto:kernel-discuss-request-CN5wO63fgwogsBAKwltoeQ@public.gmane.org?subject=subscribe>
Sender: kernel-discuss-bounces-CN5wO63fgwogsBAKwltoeQ@public.gmane.org
Errors-To: kernel-discuss-bounces-CN5wO63fgwogsBAKwltoeQ@public.gmane.org
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Linux Fbdev development list <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Miguel Ojeda <maxextreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-discuss-CN5wO63fgwogsBAKwltoeQ@public.gmane.org, Luming Yu <Luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 6 Dec 2006 15:10:44 +0000 (GMT) James Simmons wrote:

> 
> > > of Mr. Yu for acpi. Also this class could in time replace the lcd class 
> > > located in the backlight directory since a lcd is a type of display.
> > > The final hope is that the purpose auxdisplay could fall under this 
> > > catergory.
> > > 
> > > P.S
> > >    I know the edid parsing would have to be pulled out of the fbdev layer.
> 
> That patch was rought draft for feedback. I applied your comments. This 
> patch actually works. It includes my backlight fix as well.

BTW, this patch version contains trailing whitespace
which should be cleaned up:

Warning: trailing whitespace in lines 33,158 of drivers/acpi/video.c
Warning: trailing whitespace in line 10 of drivers/video/display/Kconfig
Warning: trailing whitespace in line 41 of include/linux/display.h
Warning: trailing whitespace in lines 49,1053,1084,1133 of drivers/video/Kconfig
Warning: trailing whitespace in line 3 of drivers/video/display/Makefile

---
~Randy
