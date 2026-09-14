Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0BE36AB56
	for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789407174; cv=pass; b=OjzReDv1cW4LUbpXURZ8Q7NpyqYUNNFRwX2x9fm9TaJF7+IJPTY2OX94ynOYbFqnoBwce8l1M1NQ9vGPhhkXdyYjLNDXn514t2n7xqd7sSJ90eCpPLJULM1L0lESnOtnjcjLDSnEmEquET1oQgYlEkvHMC4tTqdhZbB5GRXEzGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789407174; c=relaxed/simple;
	bh=gCtcRw+qNHNStAJYTVYJOoSF1vMwsMIbo21sJaqXQqw=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jp3qZ0/oP5SFNKyd9WBscMQdpYddr6uWaSXC4xc76Osq7HDmaNRVWjB1rjQ8iqBXEBkOPz3f6V6Q+wrB7UF/NFeR8kZWdQHMIKk3EjHeHli/Ue/8NcW4O5y5fg6a7tIBS4k5amNSUqTFYxTzRXYeTUgWh53CYv1+fKuaqetfXH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POQUs0QH; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POQUs0QH"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae54so4627291a12.3
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 10:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789407168; cv=none;
        d=google.com; s=arc-20260327;
        b=N1YTY1pVeESRv7pOlRfwdfRqxo22wa4rvwbrAXEH5QGMGRcuV1ikQG9SXejF7Wpz4t
         6BAJTfNG01B8gs0QPtHVMHLNj/sFkKLSsYC2/jbQtw9A7DZZ0s/DzNCZH1dEvPh5XhLc
         eA+zvk4MY1aHQHmg8TKdSV1mLy8FE0FArsVfQbc1o2ZlvXmhl7rg3bevx4/kIlY3IyFC
         gabfOA1zKkMgwrbl/AY9++4etbTHPP95bjMeTylM6XJKIeC+Gtx/48jwrFtNYl9IX/G7
         P+pSQqIIXfmQaSeICphe65pwHc04/3cZ9YnQ0BxnZcrKwzFoGQa0a+p3+L3BFymBNtug
         b0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=gCtcRw+qNHNStAJYTVYJOoSF1vMwsMIbo21sJaqXQqw=;
        fh=oK/lU2N/o/UAThNUDEre8d4VBOBlIrHXV60zEZOm5l0=;
        b=nbRudK+a60UrsMgS++D63lcI0PTQh/4zF7qBZ0B/ktWSmxpu8WXAuz3AnOwNtFKUPU
         6Bfqi+593DJTHMRwxRDvQ+h6HJbXfeKIj+Z3C9lOGnV+MD3Mh3cfE6++xw1lKSIwEE9m
         9zC2L0qpuLEnUgAt56GlXUGbr5JUTHg4C5gjzyOjvEM0ZVzUPvlejiPYSHDvnlbFfkVh
         4/h7kI5ymLJicdqOaVvVqYr1r4LL1c6nbqgK1Ir9m6EXWMUxi/jG+ou4u88DzbXOEHY0
         jGT5Q0bu1zU75u0ycvknWHioqaqWjahCYYi4f9qTXyRpDpSFRYqRpJxgc3mE59nAHJE+
         g3ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789407168; x=1790011968; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gCtcRw+qNHNStAJYTVYJOoSF1vMwsMIbo21sJaqXQqw=;
        b=POQUs0QHEvLkF4InMVkMDvXrmA1vA3QH27I7JAkFGQEwL7UHrV1FQ569DV6Jb1a8xF
         GUCH+HkbUWAgB6E9Jjqf8ok2m7ZMYCh+pRBHtOjPQW8dBB4EqJ9IpmsRFIJZ6oFu5rtp
         RagZhY/jNfQxd5UyCMo7bEVfo6I5jct9KcPMQ0nkuUckWGxiqHLqSlHepIfaIlXEm5fC
         XbG3taBBv9d0IHPMePAhDdxL5l0n2Nu0gIt7njKjgLX7Ca1Iz5lkYlVCedvGJVBAoMAG
         6RK8VWYrNkY2ratB395tkD2q4RxONYks9HzyFoj972EgUfrOjzSPsAj3MwT3ZAa3USXw
         fLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789407168; x=1790011968;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gCtcRw+qNHNStAJYTVYJOoSF1vMwsMIbo21sJaqXQqw=;
        b=KmAMRNcvuYPVxv5uicIlK0GzLVo15vDtNRKVubGSTabE5BrcjCy7BBa2rynNNYXUOi
         4rL7nKXjadh0H4MCupvL6ozk48qH81S6A9v8CEpOcgFDEFmQtuCkBmfhz2fbvh0BX9bn
         RwWIvdrWa5C+98phPO57Zp/SOZRHzwpeTzvIqANHh6LKoEdtoY2C6tw6xJIIIUnk4isU
         ysn0gKpJgDf3l4nzkjrRwxnZYxD0NI87Q0NF8TP4jUh2iTNwJ0cC2nmUr3n7W4TRkFWo
         bnwWBhF9rPaL9jQwP57UzmWFJiONjx3yQ5goE1Jn8bR0fKCVU5tntT75gfCVgb8LPATF
         R/iA==
X-Forwarded-Encrypted: i=1; AKwUvByGh55+o6nTs+MVer3FVDP2mjQlwunX1zdSiqrHvexm1Dw6vGMZae/rAmZ0T96pu9tix/mAA4zZfP99ww==@vger.kernel.org
X-Gm-Message-State: AFuF++nqqUNCgni3ex28py4ATrSE1ur6LWUa03+VJ/mXiMA5A1A1eEcJ
	xfBh06AsyhDdGdgpf2kQJ85QOsyp5Lnz6FvGjpkWuLq31VqEy6tSAUIKVugWVRsfIDZ8GNgqtR+
	BByYa+6R7SuBB6ZF6k/IhLa1IG06jaQA=
X-Gm-Gg: AYBFou1uCt010LRzVWi9HxN1Ef/rVptmmllxMosPHF4lZrQ+I//iSFBWmn5f96ZrpG0
	3uohuGIB5tL9WTHZ+wLTvcmhVIF+dxs9xGZUrI/6zL43oyZyEHcEN1wYGAD9b2lzJKOCbF6zXpk
	rO4j8QiiDAvmNdmFwo+5OCyCLyvn/DZQiVx4rwIAO5SDa1PUBWRA9h/tlTlYyAqJb/MA0a8y3Cf
	7Ertgf6VEYDRh6lrmWCmEuijl6kEdEOfUg7+w/Ji02/KaHLfz16vJPzVww6xtluOJdoYxBdpTGT
	8QPBtKelRea2H8I3TsimAyT+pp5B6H69ew3gY47LeGVCdqmTpfEwi5WwjSUhRnDxU3G1UoY+jqa
	OrjxQb7ZTrm3mnPBFWhDpCfH2SgLHLVWZXlwuoro=
X-Received: by 2002:a05:6402:24d3:b0:6a9:a281:ca8a with SMTP id
 4fb4d7f45d1cf-6a9f6379705mr4277384a12.20.1789407168020; Mon, 14 Sep 2026
 10:32:48 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 14 Sep 2026 12:32:46 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 14 Sep 2026 12:32:45 -0500
In-Reply-To: <aqe2K0nVppBFSidV@stanley.mountain>
References: <20260913040140.4517-1-gaberashawn@gmail.com> <20260913040140.4517-2-gaberashawn@gmail.com>
 <aqe2K0nVppBFSidV@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gabriel Changamire <gaberashawn@gmail.com>
Date: Mon, 14 Sep 2026 12:32:45 -0500
X-Gm-Features: AcwNN1WpByfxKhF0aBLisXpqJcCGb5hY09UxTHQsDO2h2LA-o97HI9q9YhD-9kw
Message-ID: <CACKJOpCHzkwX3G=mrbe0i8Xj79RK7648EoD7BXuKqLM9JuPe3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: sm750fb: remove unused definitions from ddk750_reg.h
To: error27@gmail.com
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the Acked-by and for the feedback on patch 2. That makes
sense =E2=80=94 I=E2=80=99ll drop patch 2 and leave those register definiti=
ons in
place.

Regards,
Gabriel

On Mon, 14 Sep 2026 11:54:03 +0300, Dan Carpenter <error27@gmail.com> wrote=
:
> On Sun, Sep 13, 2026 at 04:01:40AM +0000, Gabriel Changamire wrote:
> > The sm750fb TODO asks for unused code to be removed. Of the 1203
> > register and field definitions in ddk750_reg.h, 1046 are referenced
> > neither by the rest of the driver nor, transitively, by any definition
> > that is referenced.
> >
> > Remove them, together with section comments that are left with no
> > content beneath them. The include guard and all VALIDATION_CHIP
> > conditional blocks are preserved.
> >
> > Build-tested: all driver objects are byte-identical before and after
> > the change. No functional change.
> >
> > Signed-off-by: Gabriel Changamire <gaberashawn@gmail.com>
> > ---
>
> These macros are just documentation and they don't hurt readability.
> They probably improve readability.
>
> regards,
> dan carpenter
