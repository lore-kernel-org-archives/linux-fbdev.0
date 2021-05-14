Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD60AC433B4
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 May 2021 18:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9245961440
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 May 2021 18:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhENSbd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 14 May 2021 14:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhENSbc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 14 May 2021 14:31:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A2DC061574
        for <linux-fbdev@vger.kernel.org>; Fri, 14 May 2021 11:30:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lz27so23059ejb.11
        for <linux-fbdev@vger.kernel.org>; Fri, 14 May 2021 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HbsFzf/6uE8/vghKo6cKrHWCyJcOabDGOcn6Hrn7dcI=;
        b=DCYZozQrMzknue6/EWuFmrYFlWMetVMt8Dmq65ypZNXDxu9hQw677RZsR4yZkbfMQ4
         Y6pwoY9/eto3ToMEMFwHALm0FAO4vO38F5ORdjb5yDrn1Zh541QjFzH+HhSGLWO0Oa12
         i7jcZ6xtUujNIIebz2U6mVmVFv84z0I3tn664=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HbsFzf/6uE8/vghKo6cKrHWCyJcOabDGOcn6Hrn7dcI=;
        b=jq+FRFS0DoU54Ww7jfvaiJJ+oFxJzXWfM3vNNnRFQrP7h98IXFQNb3qIkLGi6xS8YA
         JWVSm0jfFX3FnxI3L/9xifUzCneSnHps+rbz+ph8+81pFoLHqSwfD7M1API27daZved4
         bNXaN2TM/YfEWVq8leNXqhnj5RYQO3SWXH25dKEecg5Y4mem/UYfCEpA+5p5/aqzkSCD
         AsYyIL1wqw4454D47gvmWYUuL1RdKh9n7sHWH5QlmKaqkO+HJ5Miro0Q0sUHAOXoEr1R
         Ur8KzFAeWZ0kSnt6TPq8PZOT09pelX/8wDhmocv/aImvWIX/WpEHvtXWBpziiHuSya1Q
         R4EA==
X-Gm-Message-State: AOAM530J3shJ9Xsp/pICya9GKpGS/3Oj5pb/ywMPBhVcZwvqFpuvmP0X
        xild1uoPZJ3QgCt3dc+wBKOdWFJ/MJM/B2eomQk=
X-Google-Smtp-Source: ABdhPJxUcz1EL62ECgJykX4y/UaKDTXVAYtpQedDQO5PJxaVKQkV1xnYx2Hj9F8WvpwPyYpi5qLfQQ==
X-Received: by 2002:a17:906:1e0b:: with SMTP id g11mr49663702ejj.291.1621017019280;
        Fri, 14 May 2021 11:30:19 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id i6sm5113576eds.83.2021.05.14.11.30.19
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 11:30:19 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id a4so184331wrr.2
        for <linux-fbdev@vger.kernel.org>; Fri, 14 May 2021 11:30:19 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr32461268lfs.377.1621016624959;
 Fri, 14 May 2021 11:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006bbd0c05c14f1b09@google.com> <6e21483c-06f6-404b-4018-e00ee85c456c@i-love.sakura.ne.jp>
 <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp>
 <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
 <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com> <CAHk-=whN=zrJ8BOLaGsJDH8d3sXLEoXA2DVsCq40OAUc1npOOw@mail.gmail.com>
In-Reply-To: <CAHk-=whN=zrJ8BOLaGsJDH8d3sXLEoXA2DVsCq40OAUc1npOOw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 May 2021 11:23:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=winm7rEueQ2moqMZWWNNywu_9eVUrT7g0a30C8fhJojTQ@mail.gmail.com>
Message-ID: <CAHk-=winm7rEueQ2moqMZWWNNywu_9eVUrT7g0a30C8fhJojTQ@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: vga16fb: fix OOB write in vga16fb_imageblit()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Antonino A. Daplas" <adaplas@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000001b409405c24e5891"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

--0000000000001b409405c24e5891
Content-Type: text/plain; charset="UTF-8"

On Fri, May 14, 2021 at 10:37 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> IOW, something like this would seem fairly simple and straightforward:

Proper patch in case syzbot can test this..

                  Linus

--0000000000001b409405c24e5891
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-vt-don-t-allow-text-mode-resizing-when-in-KD_GRAPHIC.patch"
Content-Disposition: attachment; 
	filename="0001-vt-don-t-allow-text-mode-resizing-when-in-KD_GRAPHIC.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_koon84w90>
X-Attachment-Id: f_koon84w90

RnJvbSBiMzNjYTE5NWNlY2VhNDc4NzY4ZGUzNTNiM2FlOTc2YzA3YTY1NjE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IEZyaSwgMTQgTWF5IDIwMjEgMTE6MDY6MTIgLTA3MDAKU3ViamVjdDog
W1BBVENIXSB2dDogZG9uJ3QgYWxsb3cgdGV4dC1tb2RlIHJlc2l6aW5nIHdoZW4gaW4gS0RfR1JB
UEhJQ1MgbW9kZQoKVGhlIFZUIGxheWVyIGl0c2VsZiBqdXN0IGtlZXBzIHRyYWNrIG9mIHRoZSB1
bmRlcmx5aW5nIHRleHQgY29udGVudHMKanVzdCBmaW5lLCBidXQgaWYgdGhlIHVuZGVybHlpbmcg
aGFyZHdhcmUgZHJpdmVyIGhhcyBhIGNvbl9yZXNpemUoKQpmdW5jdGlvbiwgd2UgY2FuJ3QganVz
dCBpZ25vcmUgaXQgd2hlbiBpbiBLRF9HUkFQSElDUyBtb2RlLgoKU28ganVzdCByZWZ1c2UgdG8g
ZG8gYSB0ZXh0IG1vZGUgcmVzaXplIGlmIHdlJ3JlIG5vdCBpbiB0ZXh0IG1vZGUuCgpSZXBvcnRl
ZC1ieTogVGV0c3VvIEhhbmRhIDxwZW5ndWluLWtlcm5lbEBpLWxvdmUuc2FrdXJhLm5lLmpwPgpS
ZXBvcnRlZC1ieTogc3l6Ym90IDxzeXpib3QrMWYyOWUxMjZjZjQ2MWM0ZGUzYjNAc3l6a2FsbGVy
LmFwcHNwb3RtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPgotLS0KIGRyaXZlcnMvdHR5L3Z0L3Z0LmMgfCA3ICsrKysr
Ky0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3R0eS92dC92dC5jIGIvZHJpdmVycy90dHkvdnQvdnQuYwppbmRleCAw
MTY0NWU4N2IzZDUuLmYyNGU2MjdiNzQwMiAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvdnQvdnQu
YworKysgYi9kcml2ZXJzL3R0eS92dC92dC5jCkBAIC0xMTcxLDggKzExNzEsMTMgQEAgc3RhdGlj
IGlubGluZSBpbnQgcmVzaXplX3NjcmVlbihzdHJ1Y3QgdmNfZGF0YSAqdmMsIGludCB3aWR0aCwg
aW50IGhlaWdodCwKIAkvKiBSZXNpemVzIHRoZSByZXNvbHV0aW9uIG9mIHRoZSBkaXNwbGF5IGFk
YXBhdGVyICovCiAJaW50IGVyciA9IDA7CiAKLQlpZiAodmMtPnZjX21vZGUgIT0gS0RfR1JBUEhJ
Q1MgJiYgdmMtPnZjX3N3LT5jb25fcmVzaXplKQorCWlmICh2Yy0+dmNfc3ctPmNvbl9yZXNpemUp
IHsKKwkJLy8gSWYgd2UgaGF2ZSBhIHJlc2l6ZSBmdW5jdGlvbiBidXQgYXJlIGluIEtEX0dSQVBI
SUNTIG1vZGUsCisJCS8vIHdlIGNhbid0IGFjdHVhbGx5IGRvIGEgcmVzaXplIGFuZCBuZWVkIHRv
IGVycm9yIG91dC4KKwkJaWYgKHZjLT52Y19tb2RlID09IEtEX0dSQVBISUNTKQorCQkJcmV0dXJu
IC1FSU5WQUw7CiAJCWVyciA9IHZjLT52Y19zdy0+Y29uX3Jlc2l6ZSh2Yywgd2lkdGgsIGhlaWdo
dCwgdXNlcik7CisJfQogCiAJcmV0dXJuIGVycjsKIH0KLS0gCjIuMzEuMS4zNjUuZ2EyYTA1YTM5
YzUKCg==
--0000000000001b409405c24e5891--
