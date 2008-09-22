From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: Setting interlace mode with fbdev fbset
Date: Mon, 22 Sep 2008 21:54:02 +0200
Message-ID: <20080922215402.cb977d66.krzysztof.h1@poczta.fm>
References: <376ea3380809221057j2bb9115did274c3d96a11ec2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1KhrUt-0005j8-Ie
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Sep 2008 19:55:03 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KhrUf-0006dO-WA for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Sep 2008 19:55:03 +0000
In-Reply-To: <376ea3380809221057j2bb9115did274c3d96a11ec2a@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jon Dufresne <jon.dufresne@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, 22 Sep 2008 10:57:02 -0700
"Jon Dufresne" <jon.dufresne@gmail.com> wrote:

> Hi,
> 
> I am trying to confirm that the fbdev driver I'm developing works
> correctly with interlace modes. First thing I need to know, is when
> passing mode parameters to the fbdev using fbset, should the values be
> per field, or per frame? So for example I want to set my monitor to
> 1080i, which of the following commands looks more correct:
> 
> fbset -g 1920 1080 2048 2048 32 -t 13468 148 88 30 4 44 10 -hsync high
> -vsync high -laced true
> 
> or
> 
> fbset -g 1920 540 2048 2048 32 -t 13468 148 88 15 2 44 5 -hsync high
> -vsync high -laced true
> 
> notice in the second command (which is the specs per field), more than
> just the vertical lines is halved.
> 

Look at the /etc/fb.modes file. The interlaced modes does not set
 any halves of values.  The values are the same as for the non-interlaced
 modes. It is up to driver to convert them into correct register settings
if the "laced" parameter is set (see tridentfb or pm2fb drivers).

Regards,
Krzysztof

----------------------------------------------------------------------
Kredyt Hipoteczny w Banku Millennium - zdobywca Zlotego Lauru Klienta!
Sprawdz >> http://link.interia.pl/f1f15


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
