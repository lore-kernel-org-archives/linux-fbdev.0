From: Andrew Lutomirski <luto@mit.edu>
Date: Thu, 26 May 2011 14:55:38 +0000
Subject: Re: [PATCH 3/4] efifb: Fix an integer-to-pointer size warning
Message-Id: <BANLkTi=C1oyzbv_okXp8SJNxAdXyywesNw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0c405ceeca72c92d25cb6ee4bc92c35d2cb15019.1306418703.git.luto@mit.edu>
In-Reply-To: <0c405ceeca72c92d25cb6ee4bc92c35d2cb15019.1306418703.git.luto@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Thu, May 26, 2011 at 10:34 AM, Peter Jones <pjones@redhat.com> wrote:
> On 05/26/2011 10:13 AM, Andy Lutomirski wrote:
>> Signed-off-by: Andy Lutomirski <luto@mit.edu>
>
> Signed-off-by: Peter Jones <pjones@redhat.com>

I got beaten to the punch:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=DC3e5b6a6e842116ec2436161adf31877f09b6b9

Feel free to drop this patch.  The others should still be fine.

--Andy
