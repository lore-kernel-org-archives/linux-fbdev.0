From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: 2.5 offb breakage
Date: Wed, 31 Jul 2002 19:42:49 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020731174249.19410@192.168.4.1>
References: <Pine.LNX.4.44.0207311014100.13905-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [217.167.51.129] (helo=zion.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17ZxUY-0000jy-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 31 Jul 2002 10:42:34 -0700
In-Reply-To: <Pine.LNX.4.44.0207311014100.13905-100000@www.transvirtual.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@transvirtual.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

>
>Sorry I have been away for some time. I'm looking for work :-(
>
>> What is the correct fix ? Changing back offb to set dispsw or
>> changing gen_set_disp() to set dispsw for all bit depth ?
>
>I found what the problem was. The soft accel files cfb*.c where not being
>linked into off.c. Try this patch and tell me if everything works. BTW you
>need to have CONFIG_FBCON_ACCEL set. Eventually all the fbcon-cfb* stuff
>will go away.

I have fixed that for a long time or it wouldn't link anyway...

So if I don't have CONFIG_FBCON_ACCEL, it dies in fbcon_setup because
dispsw is not set, if I have CONFIG_FBCON_ACCEL set, it dies in cfb_imageblt,
I think it's display->fb_info that is null, but I have to dbl check.

Why would you kill the fbcon-cfg stuffs ? That would mean making
CONFIG_FBCON_ACCEL not to be an option then. Or simple framebuffers like
offb wouldn't work.

>> Also, when code in fbcon_accel.c is calling things like
>> cfb_imageblit, it uses the "fb_info" field of structure
>> struct display. Where is this supposed to be initialized ?
>> It doesn't seem it's done in the drivers themselves (surely
>> not in offb).
>
>The upper fbcon code sets that. See fbcon_init in fbcon.c.




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
