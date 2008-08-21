From: Anatolij Gustschin <agust@denx.de>
Subject: Re: Background color Framebuffer console
Date: Thu, 21 Aug 2008 14:21:39 +0200
Message-ID: <48AD5DD3.2040505@denx.de>
References: <8c675e9b0808210334q7871e06cnb926c7df0fe2055c@mail.gmail.com>
	<48AD5BA4.3050009@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KW9Aj-0004wR-7V for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Aug 2008 05:21:49 -0700
Received: from mail-out.m-online.net ([212.18.0.9])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KW9Ah-00066t-OW
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Aug 2008 05:21:49 -0700
In-Reply-To: <48AD5BA4.3050009@denx.de>
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
To: Amol Lad <amol.lad@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Anatolij Gustschin wrote:

<snip>

> You could also try to set other bg colors and see what happens:
> 
> # for ((i = 40; i < 51; i++)) do echo -e "\033[${i}m > /dev/tty0"; done

The above command should be 

# for ((i = 40; i < 51; i++)) do echo -e "\033[${i}m" > /dev/tty0; done

Sorry, my typo.

Best Regards,
Anatolij

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
