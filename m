From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Mon, 23 Mar 2015 13:16:16 +0000
Subject: Re: [PATCH RESEND 2 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <CAA5enKaj78eY9vG=7vGhBb_=EpwV6yyKKMjNCUY7BuJvDDvpgg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426864935-29350-1-git-send-email-lstoakes@gmail.com>
 <20150323105323.GA10964@mwanda> <CAA5enKaPnRBT=8Tkx7rm6GQYXMvA=pwxmRYpnkRU8uHok8ypUg@mail.gmail.com>
 <20150323115129.GI10964@mwanda> <CAA5enKZ0gLUPmhWrC5-WOqF2E9v43x9uvEEy-J_we9-Ty=SUPw@mail.gmail.com>
 <20150323125513.GB8151@sudip-PC> <CAA5enKbKJm2QeH+rbXB+NKw7+O=eXN-01ifLUZPupJ9BF3q+fQ@mail.gmail.com>
 <20150323131422.GE8151@sudip-PC>
In-Reply-To: <20150323131422.GE8151@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org

On 23 March 2015 at 13:14, Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:
> On Mon, Mar 23, 2015 at 01:02:52PM +0000, Lorenzo Stoakes wrote:
>> On 23 March 2015 at 12:55, Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:
>>
>> > and you need to send v3 now :(
>> > your series is not applying. Please refresh it against staging-testing
>>
>> Applies to staging-testing for me. Are you sure you're applying the
>> correct 'RESEND 2' patches?
> i think. if you do git log drivers/staging/sm750fb/
> are you getting the first patch author as
> Ragavendra Nagraj <ragavendra.bn@gmail.com> ?

Yep:-

commit de99befd18c10d8085182a1facbb4b8760b2b6fe
Author: Ragavendra Nagraj <ragavendra.bn@gmail.com>
Date:   Wed Mar 18 02:37:42 2015 -0700

    staging: sm750fb: Fixed no space and indent warns

I've tried applying resend 2 patches to both linux-next and
staging-testing in Greg's staging.git tree, they apply in both places.

-- 
Lorenzo Stoakes
https:/ljs.io
