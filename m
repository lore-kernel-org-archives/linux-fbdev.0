From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH 23/24] matroxfb: Color setting fixes
Date: Sun, 03 Jun 2007 03:36:07 -0700
Message-ID: <46629997.6060603@vc.cvut.cz>
References: <46614341.5040402@gmail.com> <46625313.9050109@vc.cvut.cz>
	<b00ca3bd0706030259mf808c17g25246aac5876547d@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HunRU-0007JJ-Pz for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Jun 2007 03:36:13 -0700
Received: from mailgw.cvut.cz ([147.32.3.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HunRS-0003sH-1r
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Jun 2007 03:36:11 -0700
In-Reply-To: <b00ca3bd0706030259mf808c17g25246aac5876547d@mail.gmail.com>
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
To: Antonino Daplas <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino Daplas wrote:
> On 6/3/07, Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
>> Antonino A. Daplas wrote:
>> > - the pseudo_palette is only 16 elements long.
>> > - do not write to the pseudo_palette if regno (array index) is more 
>> than 15
>> >
>> > Signed-off-by: Antonino Daplas <adaplas@gmail.com>
>>
>> NACK.  If you want to remove entry #16, you need to also fix all uses of
>> it - matroxfb_crtc2 uses it, matroxfb_accel as well.  Before hardware
>> cursor was removed from fbcon it was used by hardware cursor - now it is
>> only set, but never used.  Removing entry without removing code to set
>> entry #16 memory corruption will occur.
>>                                                                 Petr
> 
> Okay, I see it now.  Andrew, drop the patch for matroxfb.
> 
> Petr,
> 
> Do you have plans for the 17th entry?

No.  It was used in the past when hardware XOR cursor was used (so 
palette 4bpp/8bpp needed XOR mask 0x0F, while truecolor modes needed 
0x7FFF for 15bpp/0xFFFF for 16bpp/0xFFFFFF for 32bpp).  Now matroxfb 
uses software cursor (which just repaints complete character) and I have 
no plans to resurrect it.

So feel free to remove code which sets that entry.  I believe that 
passing matroxfb sources through "grep -v 'cmap\[16\]\|pal\[.*F'" 
"fixes" it...

petr@gwy:/usr/src/linus/linux-2.6.22-rc3/drivers/video/matrox$ grep 
'cmap\[16\]\|pal\[.*F' *
matroxfb_accel.c:       pal[i] = 0xFFFFFFFF;
matroxfb_accel.c:       pal[i] = 0x0F0F0F0F;
matroxfb_accel.c: 
ACCESS_FBINFO(cmap[16]) = 0x7FFF7FFF;
matroxfb_accel.c: 
ACCESS_FBINFO(cmap[16]) = 0xFFFFFFFF;
matroxfb_accel.c:                               ACCESS_FBINFO(cmap[16]) 
= 0xFFFFFFFF;
matroxfb_accel.c:                               ACCESS_FBINFO(cmap[16]) 
= 0xFFFFFFFF;
matroxfb_crtc2.c:       m2info->cmap[16] = 0xFFFFFFFF;

								Petr


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
