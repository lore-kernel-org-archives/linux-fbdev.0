From: Laszlo Ersek <lersek@redhat.com>
Date: Sat, 17 Jun 2017 16:51:56 +0000
Subject: Re: [Qemu-devel] [RFH] qemu-2.6 memory corruption with OVMF and linux-4.9
Message-Id: <2e7e9fe3-e603-d75f-84c6-d0fb048266da@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5d090b82-dae7-ac67-a032-92c2e776b70f@univention.de>
In-Reply-To: <5d090b82-dae7-ac67-a032-92c2e776b70f@univention.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Hahn <hahn@univention.de>
Cc: qemu-devel@nongnu.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org

On 06/16/17 19:03, Philipp Hahn wrote:

> Comparing the corrupted (left) with the supposed (right) driver shows
> the following pattern:
>> /tmp/uefi.bin [+]                                   15038,1      Alles /tmp/uefi.ko [+]                                    15038,1      Alles
>>   003ac00: e801 0000 0000 0000 3c00 0000 1700 0000  ........<.......  |  003ac00: e801 0000 0000 0000 5e8c 0000 1000 f1ff  ........^.......
>>   003ac10: 785b 3e8a 0000 0000 3c00 0000 0700 0000  x[>.....<.......  |  003ac10: 785b 3e8a 0000 0000 0000 0000 0000 0000  x[>.............
>>   003ac20: 778c 0000 1200 0200 3c00 0000 0700 0000  w.......<.......  |  003ac20: 778c 0000 1200 0200 f018 0000 0000 0000  w...............
>>   003ac30: 1e00 0000 0000 0000 3c00 0000 1700 0000  ........<.......  |  003ac30: 1e00 0000 0000 0000 8c8c 0000 1200 0200  ................
>>   003ac40: 7007 0000 0000 0000 3c00 0000 0700 0000  p.......<.......  |  003ac40: 7007 0000 0000 0000 1400 0000 0000 0000  p...............
>>   003ac50: 9c8c 0000 1200 0200 3c00 0000 0700 0000  ........<.......  |  003ac50: 9c8c 0000 1200 0200 0022 0000 0000 0000  ........."......
>>   003ac60: 4000 0000 0000 0000 3c00 0000 1700 0000  @.......<.......  |  003ac60: 4000 0000 0000 0000 ac8c 0000 1000 f1ff  @...............

Let me give you a different visual representation. First good, then bad.

(I also recommend using the "vbindiff" tool for such problems, it is
great for picking out patterns.)

          ** ** ** ** ** ** ** **   8  9 ** ** ** 13 14 15
          -- -- -- -- -- -- -- --  -- -- -- -- -- -- -- --
00000000  01 e8 00 00 00 00 00 00  8c 5e 00 00 00 10 ff f1
00000010  5b 78 8a 3e 00 00 00 00  00 00 00 00 00 00 00 00
00000020  8c 77 00 00 00 12 00 02  18 f0 00 00 00 00 00 00
00000030  00 1e 00 00 00 00 00 00  8c 8c 00 00 00 12 00 02
00000040  07 70 00 00 00 00 00 00  00 14 00 00 00 00 00 00
00000050  8c 9c 00 00 00 12 00 02  22 00 00 00 00 00 00 00
00000060  00 40 00 00 00 00 00 00  8c ac 00 00 00 10 ff f1

00000000  01 e8 00 00 00 00 00 00  00 3c 00 00 00 17 00 00
00000010  5b 78 8a 3e 00 00 00 00  00 3c 00 00 00 07 00 00
00000020  8c 77 00 00 00 12 00 02  00 3c 00 00 00 07 00 00
00000030  00 1e 00 00 00 00 00 00  00 3c 00 00 00 17 00 00
00000040  07 70 00 00 00 00 00 00  00 3c 00 00 00 07 00 00
00000050  8c 9c 00 00 00 12 00 02  00 3c 00 00 00 07 00 00
00000060  00 40 00 00 00 00 00 00  00 3c 00 00 00 17 00 00
          -- -- -- -- -- -- -- --  -- -- -- -- -- -- -- --
          ** ** ** ** ** ** ** **   8  9 ** ** ** 13 14 15

The columns that I marked with "**" are identical between "good" and
"bad". (These are columns 0-7, 10-12.)

Column 8 is overwritten by zeros (every 16th byte).

Column 9 is overwritten by 0x3c (every 16th byte).

Column 13 is super interesting. The most significant nibble in that
column is not disturbed. And, in the least significant nibble, the least
significant three bits are turned on. Basically, the corruption could be
described, for this column (i.e., every 16th byte), as

  bad = good | 0x7

Column 14 is overwritten by zeros (every 16th byte).

Column 15 is overwritten by zeros (every 16th byte).

My take is that your host machine has faulty RAM. Please run memtest86+
or something similar.

Thanks
Laszlo
