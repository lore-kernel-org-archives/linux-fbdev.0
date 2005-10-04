From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: VESA, EDID & flat panels
Date: Tue, 04 Oct 2005 20:04:44 +0800
Message-ID: <43426FDC.7020701@gmail.com>
References: <1128380013.8267.125.camel@gaston>	 <8a0c36780510031618m48c55f45u648d867bcf0130d2@mail.gmail.com>	 <1128397436.31063.0.camel@gaston>  <434220D0.3020101@gmail.com>	 <1128407961.31063.50.camel@gaston>  <43423666.8090001@gmail.com> <1128415836.6291.12.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMmd3-0006iu-5V
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Oct 2005 06:14:45 -0700
Received: from zproxy.gmail.com ([64.233.162.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EMmd0-0002th-GV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Oct 2005 06:14:45 -0700
Received: by zproxy.gmail.com with SMTP id 14so438358nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 04 Oct 2005 06:14:29 -0700 (PDT)
In-Reply-To: <1128415836.6291.12.camel@gaston>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Benjamin Herrenschmidt wrote:
>> Here's a snippet from the HDMI specs. Not sure how helpful this is
>>
>> "8.4.3 Segment pointer
>>  Enhanced DDC allows access of up to 32 Kbytes of data. This is accomplished
>>  using a combination of the 0xA0/0xA1 address pair and a segment pointer. For
>>  each value of the segment pointer, 256 bytes of data are available at the
>>  0xA0/0xA1 address pair. An unspecified segment pointer references the same
>>  data as when the segment pointer is zero. Each successive value of the
>>  segment pointer allows access to the next two blocks of E-EDID (128 bytes
>>  each). The value of the segment pointer register cannot be read since it is
>>  reset at the completion of each command."
> 
> Yes, I have that. The problem is that the "primary" (old style) EDID
> block is supposed to contain in byte 0x7e, a value that indicates if
> there are extended stuffs available... Actually, it should contain:
> 
>  0 - no extended infos
>  1 - one more 128 bytes extension (basically to be read from the same
> 0xa0 address, as each i2c address can actually return up to 256 bytes of
> data)
>  3 - more extension blocks. The EEDID spec then talks about a "map" of
> the segments but I'm not sure where that is to be found.

One of the specs describes this map, should not be too difficult to parse.

> 
> The problem is that so far, all EDID blocks I've seen have this bit
> clear. Also, on the couple of machines i've tested, the additional 128
> bytes at address 0xa0 aren't there neither.
> 

Me too.  I've never encountered a display with extended blocks. I had
plans to write a parser for these blocks, but their rarity makes it
not worth the effort.
 
> So I wonder how widespread really is that EEDID stuff... I'm afraid the
> reason a lot of monitors come with a windows install CD is that they do
> _not_ provide those infos via EDID, but windows has a database with
> per-monitor infos (as Apple actually has in OS X) and we should probably
> do something similar. (but not in the kernel)

Yes, I agree.

Tony





-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
