From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: 2.5 offb breakage
Date: Wed, 31 Jul 2002 10:18:10 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207311014100.13905-100000@www.transvirtual.com>
References: <20020731124905.12781@192.168.4.1>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Zx73-0005tU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 31 Jul 2002 10:18:17 -0700
In-Reply-To: <20020731124905.12781@192.168.4.1>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


Sorry I have been away for some time. I'm looking for work :-(

> What is the correct fix ? Changing back offb to set dispsw or
> changing gen_set_disp() to set dispsw for all bit depth ?

I found what the problem was. The soft accel files cfb*.c where not being
linked into off.c. Try this patch and tell me if everything works. BTW you
need to have CONFIG_FBCON_ACCEL set. Eventually all the fbcon-cfb* stuff
will go away.

> Also, when code in fbcon_accel.c is calling things like
> cfb_imageblit, it uses the "fb_info" field of structure
> struct display. Where is this supposed to be initialized ?
> It doesn't seem it's done in the drivers themselves (surely
> not in offb).

The upper fbcon code sets that. See fbcon_init in fbcon.c.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/





-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
