From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Wed, 05 Mar 2003 16:59:31 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E661EE3.8060108@winischhofer.net>
References: <Pine.GSO.4.21.0303051644080.23176-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qbLa-0007nD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 08:02:22 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:
> On Wed, 5 Mar 2003, Thomas Winischhofer wrote:
> 
>>Antonino Daplas wrote:
>>
>>>>Ack. Is 16 fuzzy enough, what do you think?
>>>
>>>I think you should only accept modes where the difference is a fraction
>>>of a character width or height.  A difference more than that and
>>>clear_margins() will not work correctly.  
>>
>>How do I - from a low level fb driver - determine the character size?
> 
> 
> You cannot. That's called fbcon-fbdev separation.

My question was, basically, meant ironic.

But this is funny: You tell me that the difference should not exceed the 
fraction of a character, but it is impossible to find out how wide/tall 
characters are.

Guys, that won't work. I have to deal with LCD displays and TV output as 
well (not to say "mainly") and I can't just set up odd modes like 
800x592, or mode resolutions based on calculations with any possible odd 
font dimension.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net            http://www.winischhofer.net/





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
