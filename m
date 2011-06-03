From: Tormod Volden <lists.tormod@gmail.com>
Date: Fri, 03 Jun 2011 09:26:51 +0000
Subject: Re: [PATCH 21/29] s3fb: use display information in info not in var
Message-Id: <BANLkTik7=4xsvpsSbjWCvLVUw=bHsn1b6w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306364301-8195-22-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1306364301-8195-22-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Thu, May 26, 2011 at 6:31 PM, Laurent Pinchart  wrote:
> On Thursday 26 May 2011 16:12:21 Tormod Volden wrote:
>> On Thu, May 26, 2011 at 12:58 AM, Laurent Pinchart wrote:
>> > We must not use any information in the passed var besides xoffset,
>> > yoffset and vmode as otherwise applications might abuse it. Also use t=
he
>> > aligned fix.line_length and not the (possible) unaligned xres_virtual.
>> >
>> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> > Cc: Antonino Daplas <adaplas@gmail.com>
>> > ---
>> > =A0drivers/video/savage/savagefb_driver.c | =A0 16 +++++++---------
>> > =A01 files changed, 7 insertions(+), 9 deletions(-)
>>
>> The patch title is misleading, this is not the s3fb driver but the
>> savagefb driver.
>
> Yes, sorry about that. I've fixed the patch title, as well as the next pa=
tch.

Hi Laurent,
I haven't seen any updated patch posted, but anyway, the patch looks
otherwise correct to me, and I have tested it on my Savage TwisterK:

Reviewed-by: Tormod Volden <debian.tormod@gmail.com>

Cheers,
Tormod
