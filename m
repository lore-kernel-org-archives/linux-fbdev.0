From: Bryan Stillwell <bryan@bokeoa.com>
Subject: Re: radeonfb and 16bit color problem
Date: Tue, 25 Jun 2002 10:41:17 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020625104117.A31689@bokeoa.com>
References: <20020620212958.B20756@bokeoa.com> <20020624032412.27294@192.168.4.1>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from morpheus.bokeoa.com ([66.7.161.57])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17MtNa-000598-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Jun 2002 09:41:22 -0700
Content-Disposition: inline
In-Reply-To: <20020624032412.27294@192.168.4.1>; from benh@kernel.crashing.org on Mon, Jun 24, 2002 at 05:24:11AM +0200
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, Jun 24, 2002 at 05:24:11AM +0200, Benjamin Herrenschmidt wrote:
>>Any ideas would be helpful.  I tried looking at the code myself, but I'm
>>still quite new to the framebuffer code.  However, this part looked kind
>>of strange to me:
>>
>>   /* For 565, the green component is mixed one order below */
>>   if (rinfo->depth == 16) {
>>      OUTREG(PALETTE_INDEX, pindex>>1);
>>      OUTREG(PALETTE_DATA, (rinfo->palette[regno>>1].red << 16) |
>>             (green << 8) | (rinfo->palette[regno>>1].blue));
>>      green = rinfo->palette[regno<<1].green;
>>   }
>>
>>
>>BTW, I have a Radeon 8500 (QL).
>
>I wrote that part and it works just fine on my powerbook... at least
>with the radeonfb version that is in my tree, but I don't think it
>differs from the official one in this regard. You can try making sure
>it's properly setting 32 palette entries for green when using that
>mode.

I thought that piece of code looked weird because it's setting green
equal to rinfo->palette[regno<<1].green, but doesn't seem to ever use
green during the rest of the function...

BTW, don't you mean 64 palette entries for green (being that it's 6
bits)?  Anyways, I took some time this weekend to look over the code
some more, and I really doubt my problems originates in that function.
As I understand it, the palette (colormap?) will only be used when
displaying colors in text mode.

My problem seems to affect many more colors (practically all 65536 of
them), but I've yet to track it down.  I put in a request on ATI's
website to get access to the specs (hoping that'll help me), but I
haven't heard anything back from them yet.

Thanks,
Bryan

PS I'll try checking out your tree the next time I get a chance and see
if I still see the problem.


-------------------------------------------------------
This sf.net email is sponsored by: Jabber Inc.
Don't miss the IM event of the season | Special offer for OSDN members! 
JabConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
