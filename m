From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [Dri-devel] Re: [Linux-fbdev-devel] Redesign
 of kernel graphics interface
Date: Mon, 10 May 2004 22:05:57 +0100 (BST)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405102202230.6312-100000@phoenix.infradead.org>
References: <20040510182940.14049.qmail@web14924.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <20040510182940.14049.qmail@web14924.mail.yahoo.com>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Nicolas Souchu <nsouch@free.fr>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> It's not just bloat, the network code is used millions of times per second. 
> Mode setting happens occaisonally. 
 
Using that logic then Sound cards shouldn't be in the kernel at all. I 
never use my sound card continuely. I use it as a module. Would it be 
acceptable if the mode setting was modular?  

> The other problem is memory management. What is going to happen when fbdev
> starts setting the mode for both heads? Who is going to mananage the VRAM when
> the buffers get resized? OpenGL has a very complex memory management scheme
> where things can migrate from VRAM to AGP to system memory.

I know problems like this are going to exist. So I guess the idea of the 
kernel supporting multi-desktops is out then. The ruby (linuxconsole) 
project has two independent workstations running on the G400 dual head 
cards. I guess that has to go :-( 




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
