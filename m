From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 02 Feb 2015 13:42:59 +0000
Subject: Re: possible fb bug in linux-next 20150202
Message-Id: <54CF7EE3.3020404@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On 02-02-15 14:36, Rares Aioanei wrote:
> Hi,
>
> First, sorry for the unproperly-formatted mail but I'm at work and this is
> the only way. Second, I installed the latest linux-next on a Dell Latitude
> D520 at work and the kernel won't boot unless I add nofb at the command
> line. Is this a known issue or do you need me to send all the good stuff
> (dmesg, cpuinfo and so on)? If there's anything I can do to help, please
> let me know. I have some time to test.

Not sure why you are sending this to me ?

Are you using a kernel with simplefb support enabled on x86? I only maintain
the simplefb driver, and you're not supposed to use that on x86.

Eitherway please send a detailed bug report to:
"Linux Fbdev development list <linux-fbdev@vger.kernel.org>"
with me in the Cc.

Regards,

Hans
