From: Suresh Chandra Mannava <Mannava@GameBox.net>
Subject: framebuffer on 4 MegaHertz FPGA
Date: Sat, 20 Mar 2004 09:16:43 +0530
Sender: linux-fbdev-users-admin@lists.sourceforge.net
Message-ID: <405BBEA3.4040000@GameBox.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-users-admin@lists.sourceforge.net>
Errors-To: linux-fbdev-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-users>,
	<mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-users@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-users>,
	<mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-users>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-users@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net

Dear Friends,   

We are facing the problem of initializing the framebuffer for the below 
system.
We are porting Xfree86 on to a new 32bit RISC processor. We have test 
FPGA system running at 4 Mega Hertz (Bogomips 0.16) on kernel 2.4.7. 
proposed system(ASIC) runs on ~300Mhz.

My main concern is does Xfree86 can be tested on 2.6Mhz FPGA?
What is the minimum clock speed required to run X?

Our test system supports 2GB of RAM and it consists of PCI ATI Rage XL 
Graphics card.

 We started testing the generic vga16fb.c framebuffer.The basic 
intialization seems to happen perfectly.The problem comes in 
take_over_console,where framebuffer takes over the dummy console.In the 
take over console,at first step he is calling fbcon_startup which is 
getting screen base ,X and Y coordinates and clearing that location.This 
happens fine.This function is called for after some timer interval and 
hence we can say that it will be called repeatedly.The problem is that 
we cann't put any printk in between as it adversely affects the 
flow(This we found after testing vga16fb.c rigorously on intel as well 
as on our FPGA).We traversed the source code and also through object 
dumps and found that nothing is wrong.The system seems to be hung after 
some time(It is able to clear the screen).We came to this conclusion 
after giving a run and waiting for 6 hours.

We think that speed might be a problem.We need to findout first whether 
we will be able to run a framebuffer driver at 4 MHZ.Since framebuffer 
does pixel by pixel access,we think it will take a lot of time and 
anything can happen in between.We are now not in a position to predict 
what is happening.Please give your points on whether the framebuffer 
will work at such a low speed.

I request your suggestions on feasibility of initializing framebuffer 
and testing X on the above system.


Regards,
Suresh Chandra Mannava.

-- 
Suresh Chandra Mannava		
Software Engineer, Cornet Technology India, Chennai.
CSE, Research Student, Vellore Institute of Technology - India.
Email: mannava(at)vit.ac.in, Mobile: +919884278813




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
