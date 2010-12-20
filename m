From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 20 Dec 2010 16:04:53 +0000
Subject: Re: [PATCH 2/2] fbdev: Modify vsync timing calculation in wm8505fb
Message-Id: <AANLkTik9kD3gW1dQ6xe-jpyK9RQxOQJofekaO9Z9FXcC@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101220130314.GA3627@alchark-u3s>
	<20101220130957.GB3627@alchark-u3s>
	<20101220160018.GE26766@linux-sh.org>
In-Reply-To: <20101220160018.GE26766@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: "Janorkar, Mayuresh" <mayur@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vt8500-wm8505-linux-kernel@googlegroups.com" <vt8500-wm8505-linux-kernel@googlegroups.com>

2010/12/20 Paul Mundt <lethal@linux-sh.org>:
> On Mon, Dec 20, 2010 at 04:09:57PM +0300, Alexey Charkov wrote:
>> This removes the '+1' in vsync timing calculation for wm8505fb to
>> directly use values provided from the board setup code.
>>
>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>
> This is queued for .37, thanks.
>

Paul, in fact, relevant code is only scheduled for merge in .38 (it is
in linux-next right now). This does not apply to .37.

Thanks,
Alexey
