From: Marcelo Pacheco <marcelo@macp.eti.br>
Subject: Re: [BK fbdev updates]
Date: Wed, 15 Jan 2003 22:31:56 -0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E25FD7C.6040505@macp.eti.br>
References: <Pine.LNX.4.44.0301152201490.23774-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from inova101.correio.tnext.com.br ([200.222.67.101] helo=leia-out.correio.tnext.com.br)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18YxxU-0000vC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Jan 2003 16:32:36 -0800
In-Reply-To: <Pine.LNX.4.44.0301152201490.23774-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James Simmons wrote:

>>I have 2 machines that are running 2.5.56 beatifully, except for fbcon 
>>and ISDN.
>>The laptop runs ATI radeon - when I attempt to boot with radeonfb+fbcon 
>>statically linked it wraps the pixels as if the driver is using 1410 
>>pixels per row while the hardware only has 1400
>>    
>>
>
>Can you try it with the latest code. I think fixes are in the standard 
>tree for this.
>
Ok, I got some very good news. I found a workaround that lets me use 
rivafb+fbcon 99% ok.
I have a 1400x1050 LCD panel. When I boot with fbcon, it garbles the 
screen like it thinks the screen has 1450 or so pixels. I can't read 
individual characters, and the each line starts further and further to 
the right.
I can login and startx on the blind, here's an fbset output at that point:

mode "1400x1050-60"
    # D: 108.003 MHz, H: 63.983 kHz, V: 60.191 Hz
    geometry 1400 1050 1400 1050 8
    timings 9259 136 40 10 0 112 3
    rgba 6/0,6/0,6/0,0/0
endmode

The if I do an fbset -g 1280 1050 1280 1050 8, I can start seeing 
characters on the screen, here's the fbset output at this point:

mode "1280x1050-65"
    # D: 108.003 MHz, H: 68.879 kHz, V: 64.797 Hz
    geometry 1280 1050 1280 1050 8
    timings 9259 136 40 10 0 112 3
    rgba 8/0,8/0,8/0,0/0
endmode

At this point there's 3 problems:

1 - stty is still attempting to use 175 columns which would have been 
correct for 1400x1050 with a 8x16 font, but the screen is not set to 
1280, I do an stty columns 160 and that is now worked around.

2 - The cursor is gone, so I can't edit lines or run vi under fbcon.

3 - If I switch color depths, the code doesn't seem to be clearing the 
screen before rendering the new text, so I end up with 1 or more scaled 
down copies of the old text.

Starting to get useable here.

Now I'll test 2.5.58bk1 with tdfxfb+fbcon, I'll post more soon.

Thanks and I'll subscribe to linux-fbdev-devel so I can get posted on 
the updates,

Marcelo Pacheco




-------------------------------------------------------
This SF.NET email is sponsored by: A Thawte Code Signing Certificate 
is essential in establishing user confidence by providing assurance of 
authenticity and code integrity. Download our Free Code Signing guide:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0028en
