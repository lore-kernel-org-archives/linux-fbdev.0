From: "Jochen Roth" <jochen@panix.com>
Subject: Re: X endianess problem
Date: Fri, 13 Jun 2003 06:05:26 -0400 (EDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200306131005.h5DA5Qp00126@panix3.panix.com>
References: <1055496457.1853.88.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail3.panix.com ([166.84.1.74])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19QlR2-0002c4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 13 Jun 2003 03:05:28 -0700
In-Reply-To: <1055496457.1853.88.camel@thor.holligenstrasse29.lan> from "Michel =?ISO-8859-1?Q?D=E4nzer?=" at Jun 13, 2003 11:27:38 AM
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

> > Neither X nor fbi get the byte order right, though.
> 
> I think they just assume native byte order.

Yes -- Gerd Knorr set me straight on that one after I emailed him a
patch for fbi...

> > BTW, based on my debug output X never turns off the accelerator. Is
> > that OK?
> 
> fbdevHWMapMMIO() in 4.3.0 seems to disable it.

I will give that a try. I have not seen any negative side effects of
the accelerator being enabled, but it seems weird.

I also would have expected for the X server to just go and talk to
the fbdev kernel driver, instead of still mucking with the hardware
directly. At least the X server on exit at times seems to want to
reset my chip into 80x25 or 640x400 on occasion. Can't tell for sure,
my monitor does not digest the timing very well. I am fairly certain
that my driver does not do that, based on set_var() printks.

> > The hardware documentation for my chip says that there is supposed to
> > be an endian-swapped mapping for the frame buffer, essentially the
> > second 32MB of the 64MB total bar0. As far as I can tell this second
> > mapping does not byte-swap the video buffer.
> 
> Well, there's no single byte swapping working for all cases, maybe you
> need to configure it by writing to some register(s)?

Yes. I found the 2 bits 36 hours ago. X looks much nicer with BE pixels.

Thanks for your suggestions.

Jochen



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
