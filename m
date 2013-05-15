From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 15 May 2013 18:22:20 +0000
Subject: Re: [PATCH v3 6/9] radeon: Switch to arch_phys_wc_add and add a missing ..._del
Message-Id: <CALCETrXA-nbdDEv1TyU9e4mcGZzAoCTTDX33M1o31rZkgHHTFg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1368485053.git.luto@amacapital.net> <bf7788cfd4695d05f2b414735744105906650e42.1368485053.git.luto@amacapital.net>
 <CADnq5_O6tZeRVq=gmJfn3JWQGgECSE1JuonpSKgFCYSD8RCqHQ@mail.gmail.com>
 <CAH3drwbSLdjd4Y8x8YfzhM5WK+A-L7mnYeS0kdqu7MwEB5kbCQ@mail.gmail.com>
 <CALCETrVo-6cnKZsDJnBJcwGjpPbW9QAYriyjAZavaZ8O2OkjnQ@mail.gmail.com> <CAH3drwb743_q5ZrNDNsnOUUNVDMcefaq9NH3+t863OGc98-D-Q@mail.gmail.com>
In-Reply-To: <CAH3drwb743_q5ZrNDNsnOUUNVDMcefaq9NH3+t863OGc98-D-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jerome Glisse <j.glisse@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@gmail.com>

On Wed, May 15, 2013 at 7:49 AM, Jerome Glisse <j.glisse@gmail.com> wrote:
> On Tue, May 14, 2013 at 5:35 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Tue, May 14, 2013 at 6:37 AM, Jerome Glisse <j.glisse@gmail.com> wrote:
>>> On Tue, May 14, 2013 at 8:58 AM, Alex Deucher <alexdeucher@gmail.com> wrote:
>>>> On Mon, May 13, 2013 at 7:58 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>>>> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>>>>
>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>> I believe it will break something but we could deal with the fallout
>>> once it happens.
>>
>> FWIW, I'm running with this code on my machine right now using the
>> radeon driver.  Everything seems fine.  If I build without MTRRs and
>> without PAT, though, graphics are slow (as expected).  So I think
>> everything's okay.
>>
>> --Andy
>
> I am worried on p4 where i last see issue with that notably with agp.

Do you remember any details?  It looks like PAT is enabled on Pentium
4 (i.e. famliy 0xF).

--Andy
