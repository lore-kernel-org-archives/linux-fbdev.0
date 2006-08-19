From: "Steve Spano" <steve@flconsult.com>
Subject: Re: ##3 Frame Buffer Questions?
Date: Fri, 18 Aug 2006 22:43:08 -0400
Message-ID: <015101c6c339$41a607b0$6400a8c0@fleballnchain>
References: <1155946775.9630.5.camel@daplas.org>
Reply-To: steve@flconsult.com,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GEGoY-0003Rj-FU for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 Aug 2006 19:43:58 -0700
Received: from mail.danica.com ([205.232.74.72] helo=danicacomputing.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GEGoV-0004CH-VR
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 Aug 2006 19:43:58 -0700
Received: from fleballnchain (cpe-24-59-110-67.twcny.res.rr.com [24.59.110.67])
	by danicacomputing.com (mail2.danicacomputing.com)
	(MDaemon PRO v9.0.4) with ESMTP id md50001160789.msg
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 18 Aug 2006 22:43:44 -0400
In-Reply-To: <1155946775.9630.5.camel@daplas.org>
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
To: "'Antonino A. Daplas'" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

Hi Antonino,

We got the buffer working and showing now in the proc folder

So we can now do a cat random > fb0 - and that works.

Do you (or someone) know the correct pattern of magic #defines that will
put the console up on the VGA? I would like to see the startup
messages/login prompt on the VGA display.

Thanks!

Steve Spano, President
Finger Lakes Engineering
119 South Cayuga #200
Ithaca, Ny 14850
(V) 607-277-1614 x223
(C) 607-342-1150
www.FL-ENG.com - FLE's Main Website 
www.FLEDEVFORUM.com - FLE's Developer Forum

-----Original Message-----
From: Antonino A. Daplas [mailto:adaplas@gmail.com] 
Sent: Friday, August 18, 2006 8:20 PM
To: steve@flconsult.com; linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] ##3 Frame Buffer Questions?

On Fri, 2006-08-18 at 10:30 -0400, Steve Spano wrote:
> Hi Folks,
> 
>  
> 
> I have a question.
> 
> 
> Working on a "semi-custom" frame buffer for a Xilinx FPGA with the
> Microblaze.
> 
>  
> 
> The specific file we started with is already in the
> uclinux/drivers/video and is called xilinxfb.c
> 
>  
> 
> We can register the driver and a debug trace in the driver shows that
> it registers as FB0 29-0, so that should be right.
> 
>  
> 
> However, if I do a cat /dev/fb0  the linux responds by saying it can't
> open the device. It appears that somehow the default file pointer in
> dev/fb0 cannot connect to the actual driver?
> 
>  
> 
> MKNODing the driver also fails.
> 
>  
> 
> I do have other drivers that we have made that do install, so this
> isn't the first attempt at a driver.
> 
>  
> 
> Any thoughts on where I may look for some ideas on this?

What kernel version are you using?
Does it show up in /proc/fb? If it does, the device node it's bound too
should also show up.

If it does show up in /proc/fb, then make sure that info->screen_base
(in 2.6) or info->disp->screen_base (in 2.4) is pointing to the virtual
address of the framebuffer.

If publicly available, can you point us to the source?

Tony








-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
