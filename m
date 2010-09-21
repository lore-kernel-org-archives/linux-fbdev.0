From: Jon Nettleton <jon.nettleton@gmail.com>
Date: Tue, 21 Sep 2010 19:37:19 +0000
Subject: Re: [PATCH] viafb: Use proper register for bgcolor when doing MONO blits
Message-Id: <AANLkTim2RdpLs1S8LQBtxtGegE4vVUXXN_aS8ea-Merh@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921154604.2E3059D401B@zog.reactivated.net>
In-Reply-To: <20100921154604.2E3059D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Sep 21, 2010 at 10:07 AM, Daniel Drake <dsd@laptop.org> wrote:
> On 21 September 2010 18:00, Florian Tobias Schandinat
> <FlorianSchandinat@gmx.de> wrote:
>> Not really. For color blits it looks like we're doing the right thing here,
Yes you are but the code says.

 if (op = VIA_BITBLT_MONO)

*snip*
>
> Odd. That's exactly what we get on VX855 before the patch.
>

I must admit I didn't look at the code thoroughly because I am more
interested in getting my KMS code finished.  The proper fix is to have
color blits use fgcolor 0x4C and bgcolor use 0x50 and mono blits use
fgcolor 0x58 and bgcolor 0x5C.

My patch would have broken color blits, but is technically correct.
Hope that gives you the information you need to properly fix the
problem.

Jon
