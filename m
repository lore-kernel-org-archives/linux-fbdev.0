From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] nvidiafb: allow ignoring EDID info
Date: Mon, 5 Feb 2007 22:28:36 +0100
Message-ID: <cb7bb73a0702051328n50c889d9o461ac2bb9f9ea75e@mail.gmail.com>
References: <ephv35$4i3$1@sea.gmane.org>
	 <20070128160831.fb51347f.akpm@osdl.org>
	 <21d7e9970701281612q56b694edp6efd1a5556dea3fe@mail.gmail.com>
	 <20070128162907.370f5476.akpm@osdl.org>
	 <21d7e9970701281639w57edc2efw4ba620d4c1bdcee7@mail.gmail.com>
	 <cb7bb73a0701290637q2ce0ff16t28f82d0c0339a2ba@mail.gmail.com>
	 <20070130203301.GA15067@dreamland.darkstar.lan>
	 <20070204201713.GA12867@dreamland.darkstar.lan>
	 <cb7bb73a0702041317u4ca2fbabp45cf56526e57c982@mail.gmail.com>
	 <20070205201824.GA13431@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933464AbXBEV2j@vger.kernel.org>
In-Reply-To: <20070205201824.GA13431@dreamland.darkstar.lan>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Luca Tettamanti <kronos@people.it>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org

On 2/5/07, Luca Tettamanti <kronos@people.it> wrote:
> get-edid uses the BIOS, while the other two talk directly over the I2C
> bus.
>
> Try loading i2c-dev (I2C_CHARDEV); With i2cdump[1] you can read the EDID
> block, which resides at address 0x50:
>
> i2cdump N 0x50 (where N is the bus number)
>
> If you are unshure about bus number try with all the available
> /dev/i2c-* devices (you may want to unload HW monitor drivers first, so
> you don't poke at random stuff).

No luck. i2c-dev and dependencies are loaded
""" lsmod | grep i2c reports """
i2c_i801                7404  0
i2c_isa                 5152  0
i2c_piix4               8140  0
i2c_algo_pcf            6180  0
i2c_algo_pca            5380  0
i2c_algo_bit            8424  0
i2c_dev                 8548  0
i2c_core               19680  7
i2c_i801,i2c_isa,i2c_piix4,i2c_algo_pcf,i2c_algo_pca,i2c_algo_bit,i2c_dev
""""

There is no such thing as /dev/i2c* UNLESS I load nvidiafb. When I
load that, I get three busses (i2c-0, -1, and -2), but i2cdump N 0x50
gives me a nice tableau of X's all around, for all values of N. This
is using kernel 2.6.18-3 stock Debian kernel. I'll keep trying with
some variations, to see if I can get more sensible information.

-- 
Giuseppe "Oblomov" Bilotta
