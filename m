From: Steve Longerbeam <stevel@mvista.com>
Subject: Re: atyfb and radeonfb
Date: Wed, 20 Nov 2002 16:56:16 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3DDC2F30.6040709@mvista.com>
References: <Pine.GSO.4.21.0211141209250.8876-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------070206050100080903070406"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from gateway-1237.mvista.com ([12.44.186.158] helo=av.mvista.com)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Efdo-0002b4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 20 Nov 2002 16:56:24 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Steven Newbury <steven.newbury1@ntlworld.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>



--------------070206050100080903070406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Geert Uytterhoeven wrote:

>On 13 Nov 2002, Benjamin Herrenschmidt wrote:
>  
>
>>On Fri, 2002-11-08 at 16:28, Steven Newbury wrote:
>>    
>>
>>>Is atyfb in 2.4 known to work with recent Mach64 chips like Rage XL? 
>>>When I install the driver it detects the chip but results in just a 
>>>black screen.  I also noticed that it detects WRAM, whereas I am certain 
>>>it should be SGRAM.  The XFree86 driver detects everything ok and just 
>>>works.
>>>      
>>>
>>Well, I don't know if Geert still have much time to maintain
>>this driver, any help implementing the missing features would
>>be nice ;)
>>    
>>
>
>Erhm, not really...
>
>For RAGE XL support, you want to contact Steve Longerbeam <stevel@mvista.com>.
>

I reverse-engineered ATI's video BIOS on the Xpert98 PCI card (RageXL) using
a PCI bus analyzer. Got atyfb to work on embedded platforms and PC's 
that way.
It could work with other RageXL-based cards with some tweaking. I'll 
give you the
source if you're interested.

-- 
Steve Longerbeam
MontaVista Software, Inc.
office:408-328-9008, fax:408-328-3875
http://www.mvista.com



--------------070206050100080903070406
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
<br>
<br>
Geert Uytterhoeven wrote:<br>
<blockquote type="cite"
 cite="midPine.GSO.4.21.0211141209250.8876-100000@vervain.sonytel.be">
  <pre wrap="">On 13 Nov 2002, Benjamin Herrenschmidt wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Fri, 2002-11-08 at 16:28, Steven Newbury wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Is atyfb in 2.4 known to work with recent Mach64 chips like Rage XL? 
When I install the driver it detects the chip but results in just a 
black screen.  I also noticed that it detects WRAM, whereas I am certain 
it should be SGRAM.  The XFree86 driver detects everything ok and just 
works.
      </pre>
    </blockquote>
    <pre wrap="">Well, I don't know if Geert still have much time to maintain
this driver, any help implementing the missing features would
be nice ;)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Erhm, not really...

For RAGE XL support, you want to contact Steve Longerbeam <a class="moz-txt-link-rfc2396E" href="mailto:stevel@mvista.com">&lt;stevel@mvista.com&gt;</a>.</pre>
</blockquote>
<br>
I reverse-engineered ATI's video BIOS on the Xpert98 PCI card (RageXL) using<br>
a PCI bus analyzer. Got atyfb to work on embedded platforms and PC's that
way.<br>
It could work with other RageXL-based cards with some tweaking. I'll give
you the<br>
source if you're interested.<br>
<br>
<pre class="moz-signature" cols="$mailwrapcol">-- 
Steve Longerbeam
MontaVista Software, Inc.
office:408-328-9008, fax:408-328-3875
<a class="moz-txt-link-freetext" href="http://www.mvista.com">http://www.mvista.com</a>
</pre>
<br>
</body>
</html>

--------------070206050100080903070406--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
