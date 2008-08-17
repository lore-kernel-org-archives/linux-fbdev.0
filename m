From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: intelfb crashes during modprobe
Date: Sun, 17 Aug 2008 20:09:28 +0200
Message-ID: <20080817200928.15da18c6.krzysztof.h1@poczta.fm>
References: <376ea3380808140821k4e2ec102n452bcc7bb9cc3676@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KUmbM-00036A-GE for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 Aug 2008 11:03:40 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KUmbK-0003nL-03
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 Aug 2008 11:03:40 -0700
In-Reply-To: <376ea3380808140821k4e2ec102n452bcc7bb9cc3676@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jon Dufresne <jon.dufresne@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 14 Aug 2008 08:21:01 -0700
"Jon Dufresne" <jon.dufresne@gmail.com> wrote:

> Hi,
> 
> I am experimenting with using a framebuffer for video playback with
> DirectFB. The first goal of mine is to get a stable fb driver working
> that DirectFB can talk to.
> 
> My target platform is an x86 with an intel 965G chipset running
> fedora. I am attempting to use the intelfb driver to successfully
> complete this project.
> 
> I let my system boot, and then modprobe intelfb with no parameters.
> Every time the system always either reboots, or hangs with no response
> to input. Has anyone experienced this before? I can successfully do
> low resolution video playback using the vesa driver.
> 
> I've developed Linux drivers in the past and am going to dive into the
> code to see if I can solve this, and other problems. Should I be in
> direct contact with the current maintainer of this module to possibly
> point me in the right direction?
> 

Could you provide more details? Especially, if you have connected a CRT
(either real CRT or external LCD panel) or the LVDS (LCD directly to
the chip - like in laptops).

I have not experienced this but I haven't tried it either.

Regards,
Krzysztof

----------------------------------------------------------------------
Igrzyska z nagrodami! Kliknij>>>> http://link.interia.pl/f1edb 

 	


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
