From: "Alex Stewart" <alex@foogod.com>
Subject: Re: [PATCH] neofb patches
Date: Mon, 26 Apr 2004 11:12:50 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <10078.171.72.5.226.1083003170.squirrel@www.foogod.com>
References: <60004.64.139.3.221.1082827760.squirrel@www.foogod.com>
        <Pine.LNX.4.44.0404250138120.15965-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIAbN-0000Z1-B6
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Apr 2004 11:13:09 -0700
Received: from adsl-209-182-168-213.value.net ([209.182.168.213] helo=firestar.foogod.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIAbL-0002kB-2Q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Apr 2004 11:13:07 -0700
In-Reply-To: <Pine.LNX.4.44.0404250138120.15965-100000@phoenix.infradead.org>
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
To: jsimmons@infradead.org
Cc: linux-fbdev-devel@lists.sourceforge.net

>> +       /* Turn on panning for console scroll by default */
>> +       info->var.yres_virtual = 30000;
>> +       info->var.accel_flags |= FB_ACCELF_TEXT;
>> +       if (neofb_check_var(&info->var, info))
>> +               goto err_map_video;
>
>    The reason is because fb_find_mode calls check_var for us. No reason
> to
> call it twice. The large yres_virtual being 30000 that is not needed any
>  longer. The accel flag is set in neofb_check_var. The current test is
>
> if (var->bits_per_pixel >= 24 || !par->neo2200)
> 	var->accel_flags &= ~FB_ACCEL_TEXT;

Actually, look more closely at that code.  That is _unsetting_
FB_ACCEL_TEXT under some circumstances, but under the current new code it
never actually gets set anywhere.  I originally had my code your way, but
then needed to add the extra bit above to get ypanning to actually work.

yres_virtual does need to be set larger than yres in order for ypanning to
function, last I checked.  In order to set it to the correct value for the
particular card, we set it to 30000 (very large), and then call check_var
to have it scale it down to what the hardware can handle (this seems
cleaner to me than duplicating the code to properly size things in two
routines).  This must be done after the correct video mode is found by
fb_find_mode, however.  We could have set FB_ACCEL_TEXT earlier, but I put
it in the same place for clarity.

> Should we drop the bpp >= 24 test? Do you observe this problem at all
> depths.

We probably should change that to a "> 24" yeah (or maybe just get rid of
it all together).. I hadn't caught that before.  I haven't actually tested
it at 24-bit but I don't see why it shouldn't work.

-alex




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
