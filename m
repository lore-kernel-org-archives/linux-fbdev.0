From: Andrey Ulanov <drey@rt.mipt.ru>
Subject: Re: Problem with cfb_imageblit
Date: Fri, 24 May 2002 21:30:54 +0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020524173054.GA2000@gleam.rt.mipt.ru>
References: <1022214909.540.1.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from frtk-campus-gw.mipt.ru ([194.85.82.97])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17BIuE-0004IC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 May 2002 10:31:11 -0700
Received: from gleam.rt.mipt.ru (qmailr@vocord.rt.mipt.ru [194.85.82.184])
	by frtk-campus-gw.mipt.ru (8.12.1/8.12.1) with SMTP id g4OHUtXf029382
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 May 2002 21:30:55 +0400
Content-Disposition: inline
In-Reply-To: <1022214909.540.1.camel@daplas>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Fri, May 24, 2002 at 09:19:09PM +0800, Antonino Daplas wrote:
> I have an unusual problem with cfb_imageblit.  I'm not too sure if this
> is unique to my system. I get garbage pixels.  For example the
> underscore character (_) appears like this magnified:
> 
>    01234567
> 0
> .
> .
> .
> 
> 13  *******
> 14 *
> 15    **      <-- belongs to apostrophe char
> 
> It seems that the image is off by one bit and one row of pixels so it
> also includes the first row of pixels of the next character (`) in
> fontdata.
> Any comments?

Some time ago I had the same problem even under X Window and Window$. And 
it seems it's problem with hardware. Try to reduce system bus frequency.

-- 
with best regards, Andrey Ulanov.
drey@rt.mipt.ru

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
