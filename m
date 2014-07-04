From: Kewal Agola <kewalagola@gmail.com>
Date: Fri, 04 Jul 2014 07:57:51 +0000
Subject: Trouble with Virtual Terminal
Message-Id: <CAOsdogr=0wUt_hedm83SmJBDEB-50isx4i-G47U0PEeBc5U-cg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

I am using a customized ARM based platform with an LCD monitor. I am
having trouble with virtual terminal. Terminal emulator with X-serve
works fine. But as soon as I switch to virtual terminal (ctrl + alt +
F1), the characters get scrambled. If I type character 'a', at first
character 'a' looks as if it were written with a broken line,
gradually after few seconds proper shape comes up. If I enter command
"dmesg" the output looks garbled due to overlapping of two consecutive
lines.

Processor Family : ARMv7.
Linux Kernel version : 3.0.31
Operating system : ARM Ubuntu.

I know there is some issue with display driver. But I do not know what
changes could help me. Can someone suggest me the way out?

Thanks,
Kewal
