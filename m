From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 02 Feb 2015 18:37:45 +0000
Subject: Re: FB issue in linux-next-20150202
Message-Id: <54CFC3F9.3020109@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On 02-02-15 15:49, Rares Aioanei wrote:
> Hi,
>
> Can't seem to be able to boot with the kernel in the subject on a Dell
> Latitude D520. I get a stack trace and the system locks down. This is
> OpenSUSE 13.2 64-bit. Attached is all the info I could gather. Please
> let me know if there is anything else.

This seems to be an issue with the intel gfx kernel driver, please file
a bug using the instructions provided here:
https://01.org/linuxgraphics/documentation/how-report-bugs

Regards,

Hans
