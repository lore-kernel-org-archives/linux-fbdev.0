From: Thomas Jahns <Thomas.Jahns@epost.de>
Subject: Re: New fbdev patch.
Date: Mon, 5 Jul 2004 12:17:35 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040705101735.GA24286@mercury.jahnsnet.de>
References: <Pine.LNX.4.56.0406231859390.27210@pentafluge.infradead.org> <40DC328C.9010707@bitworks.com> <20040629214850.GC2871@mercury.jahnsnet.de> <40E1ECCD.7080501@bitworks.com> <Pine.LNX.4.56.0406301753470.29465@pentafluge.infradead.org> <20040702110148.GE21418@mercury.jahnsnet.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BhUsL-0007OW-GX
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 07:55:21 -0700
Received: from mail.epost.de ([193.28.100.151])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BhUsL-00069f-06
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 07:55:21 -0700
Content-Disposition: inline
In-Reply-To: <20040702110148.GE21418@mercury.jahnsnet.de> (from Thomas.Jahns@epost.de on Fri, Jul 02, 2004 at 13:01:48 +0200)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; format="Flowed"; delsp="Yes"; charset="us-ascii"
Cc: jsimmons@pentafluge.infradead.org, Richard Smith <rsmith@bitworks.com>, Thomas.Jahns@epost.de, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Hi,

On 07/02/04 13:01:48, Thomas Jahns wrote:
> On 06/30/04 18:57:28, jsimmons@pentafluge.infradead.org wrote:
>> The correct patch is here.
>> 
>> http://www.infradead.org/~jsimmons/changes.diff.gz
> 
> that does apply cleanly, but won't compile (see below). Is it perhaps
> possible to access your kernel source tree so I can search for the
> header in need of patching myself? Should set_palette(vc) have read
> fbcon_set_palette(vc, color_table)?

after I copied the defines for SCROLL_ACCEL etc. from 2.6.7-bk17 and  
replaced set_palette by fbcon_set_palette, the code compiles fine but  
still won't work. Instead of blanking the screen I now get a continued  
display of the pre-boot messages until the kernel reboots after the  
panic time runs out. Also the controlfb does not work. I think I'll try  
compiling stock 2.6.7 without the ati driver next and see if that works  
as expected when using controlfb only.

Thomas Jahns
-- 
"Computers are good at following instructions,
 but not at reading your mind."
D. E. Knuth, The TeXbook, Addison-Wesley 1984, 1986, 1996, p. 9


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
