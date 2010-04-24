From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 24 Apr 2010 10:47:34 +0000
Subject: Re: [PATCH 10/11] viafb: rework the I2C support in the VIA framebuffer
Message-Id: <4BD2CC46.4060908@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271614873-5952-1-git-send-email-corbet@lwn.net>	<1271614873-5952-11-git-send-email-corbet@lwn.net>	<4BD20D56.7080402@gmx.de>	<20100423155725.7d3b2d2d@bike.lwn.net>	<4BD221E7.7060705@gmx.de> <20100423165256.654ca5eb@bike.lwn.net> <4BD22B96.5020102@gmx.de>
In-Reply-To: <4BD22B96.5020102@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

Florian Tobias Schandinat schrieb:
> Jonathan Corbet schrieb:
>> On Sat, 24 Apr 2010 00:40:39 +0200
>> Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
>> Meanwhile, I'm a little unsure now...is there an action item for me
>> with regard to the i2c code?  I've been staring at it since your last
>> note, but I couldn't find any obvious problems.  I do have to say that
>> Harald's rework is far cleaner than what came before...
> 
> Well the main question is probably:
> How does it change the behaviour towards the hardware?
> I tend to think that OLPC might not be the only ones who did something 
> weird with it....and we already know that we shouldn't trust the 
> documentation too much.

I was able to narrow this issue down to the fourth bus. So with
if (i = 4)
	continue;
in the bus creation loop I'm able to get a working framebuffer which 
does not have the issues mentioned. Any ideas what should be done now?


Thanks,

Florian Tobias Schandinat

